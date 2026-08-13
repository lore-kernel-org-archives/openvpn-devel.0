Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F629C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZ+I9awIV/AoZiIaO1BB+s49J5y8NXkaoUrtdcBqJic=; b=BkxDqP4hZEbAR5OqtVmvwY/kKl
	EbRDFn6gpkQS5X2UCyJfSdzDOllhjVB7iFZgF+66Hx1c+DQz0VHR656LCSO6MvkjhLzaJbghFcYKp
	wqCfea/5qFRtBCCTFL5KaGfxSb+OtL7Oh3GkEYahwBMSH47HWQ1QtBN/atHMBiszRHsI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYjA-0002DT-R0;
	Thu, 13 Aug 2026 16:56:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYj8-0002DG-3e
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gE+frUA7IsOPmv5M6F+xdbFjMk7DpWpiMf0Oy/K095E=; b=HEL9Y6/U/JdYTAQjmHfNDgYU+T
 q1TgHy/dZWnOZBpvJDdIRTwWn1N+SKC3AjIcORn0+nMzYJkWtQ9LqtD5weAgguEA3vU0IulEpaUaO
 QgNgSpMhN17WW8OR/12ejvZ2OHfOrIhgsREnxIvBSho64OxzJ0dKMbzNFfbdPOMPijcw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gE+frUA7IsOPmv5M6F+xdbFjMk7DpWpiMf0Oy/K095E=; b=J
 gSwmnx3tSYXACiuutDBhV2hcFsgThKWEpsVeF3SuQIBAVsZPVsMyPtl0sMjE+ysDIWI9JiZE/FOVz
 8AqK9NBrGdVZgubyRrVMoOvKF+/Zof4DN09DGP0w98bEKFVgdEHe/TIgpOK7IcwVK6me0CRgiW1rS
 TxUniYeNCZ2+OIo0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYjA-0007f9-RT for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:56:22 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so762745e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786640175; x=1787244975; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gE+frUA7IsOPmv5M6F+xdbFjMk7DpWpiMf0Oy/K095E=;
 b=N4Mn/+4hMGGa1WIQownkteT9KRnwjNjQlGMQselmd3JDr3U1yvVjX3H0JJG7zG0bb7
 f93gPzlchzzpCc8iBa5js5VtnBSwh4nQ+lR41Y1nrRGHC3r9/JFDfQcmFR/OHqggPudp
 3ptB8/kAKIPrDxBULowhx9tedIWkuNSJAIDbNO2kMnsp0m6nCzdL6Gq1FUx9/Df1w99m
 LPbLB3U/0l2haObfNrPCltiJK9XPtT85j6udtmr3tJIov8HHZG9N1GcxjDLIkRcxMiKI
 pvhsoxt1ZIEyzMaQCjlsYOEXuZS2bzNgxphrI0vJhFvj8ROFudfJneb5BBi7XWdHR0BL
 en2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640175; x=1787244975;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gE+frUA7IsOPmv5M6F+xdbFjMk7DpWpiMf0Oy/K095E=;
 b=LMBDY33OHov7G8n9S6VfMcJmCc2ltVG7ZxuIeLjyjUxN72tdzAAVIKBd0NKj0mhEbj
 XRog81gCiFOMaClqf0FJadgkuRNiAB+nSuWhagnHR9g2G/MPRKQuSD+Hv7ThZ5BEUHNJ
 W/U985tZTccGhuz8G8IJxz2sMH7n4okAtZbK5Emp/P1O+o/wqDbmFd2dIRXkyZW4FG/r
 og5Sg/4HVKHiEduAxggo/GvrtnYu7syWV4HfMYoG+9GKZ0DEpaspNVJolVQXK+oD8XSI
 7JAA1b2P/0bYf+1QRFO2lXmiHg8Zmas4Lo+TVKFlOaq0J7sERzU+Q0ufOJI79g1bVf4s
 wGTg==
X-Gm-Message-State: AOJu0Yx4GPK+q67V5th9vpUPStTkUMXF/cg1DXOEepEnewl1h57LdOOP
 VQEhAjlJjYoaXx6b8aodW9nqYx9n7piwSBnmwxJ61MhS1kh6XvCmqP4hhOHXwph4ITOSIWKUy9O
 TJ30gF9lNamloZkE56UzMd1yL8g2uZETQV13nWm4/Wh5YJ927WgsNQBSsR8ImmogkJHKp
X-Gm-Gg: AR+sD13exE7zX7W8dkWH0tsW1LZC1y61ld74QRsDV3RD2GmG3DcwN5NBTTEH+1hGZXZ
 My/3ei55TzLzfa2wy8QIzUH+7Sd0mhyGL6TMfVO0J33apXwHn2/0xXugGgvWMLMgT2WCX1QNFw7
 4CMn8ko4UZ6QKEeGLLQ9mH5QJG8WOxTZ/iNqUaWz/iYgk8WKkV9DqN6eH+wvOLGLMpO5r7uP+HY
 J8hToAlR9kZPZQscdxTLcNKNAVlDFiczYTeQ/25w6qusxtV1xGV+aUu7nL0Qb7qdG8j0Z+40kJA
 Bts7WgJtRd0ZiZmYK77iq8B+rgY9hZP9susMHNIaeep822kqP+kX5mCYD2bm5JKCDeNVDSca/Et
 I2Ysqi6Mr+hldO0MAMm4Ns/8tLo8zS9DNdsre0PiX3JfuZW/LibqyW+OOC/euKKN7ejmxFcJYYS
 cHeXz0tjE0HnmfquvvPbwYQmqrCzWhy11Z63WBF9yBvXzGHAFVj/5UXn5zJDAveaUNL3j+Mggvo
 8j6rENX79u8SKVWb9VbCt0NQAPv5ZgwEtQB9IkII0peBcxK6crS5A10rDfuJIxhXgtUp0nrm+or
 79RZ8TuABnA41ZMrjOY+95Cw5bhiAXOm6pQP+9xSjSzQr33DhlQ=
X-Received: by 2002:a05:600c:4ed2:b0:496:c9cd:e7ab with SMTP id
 5b1f17b1804b1-499821616c1mr76578735e9.5.1786640174659; 
 Thu, 13 Aug 2026 09:56:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d5548sm1244045e9.1.2026.08.13.09.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:56:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:56:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: ac70ce4ad161b3840edbb4e9d89fb979b06d6562
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a49b2b6f82fad7148db2acf2f090f733b99e1e6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYjA-0007f9-RT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_udp_real method
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6667363541469087656=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6667363541469087656==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EljBVaS/1zs="; charset=UTF-8

--EljBVaS/1zs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#20) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Extract multi_get_instance_udp_real method
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract multi=
_get_instance_udp_real method

This is just a small refactoring to make the=
 code a little bit
better organised=2E

Change-Id: I37ade55d7674c68dd98cf4d=
fde35c4ad42e20d39
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1725
Message-Id: <20260731100844=2E3467-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38096=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
1 file changed, 25 insertions(+)=
, 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/25/1725/20

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec
index 2be085f=2E=2E0979002 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src=
/openvpn/mudp=2Ec
@@ -219,7 +219,6 @@
 handle_connection_attempt(struct mul=
ti_context *m,
                           struct link_socket *sock,
       =
                    struct mroute_addr *real,
-                          co=
nst uint64_t hv,
                           struct hash_bucket *bucket)
 {
=
     struct hash *hash =3D m->hash;
@@ -250,6 +249,7 @@
             mi =3D=
 multi_create_instance(m, real, sock);
             if (mi)
             {
=
+                const uint64_t hv =3D hash_value(hash, real);
            =
     hash_add_fast(hash, bucket, &mi->real, hv, mi);
                 mi->d=
id_real_hash =3D true;
                 multi_assign_peer_id(m, mi);
@@ -27=
9,6 +279,28 @@
 }
 
 /**
+ * Looks up an multi instance by its real address=
 (IP and port)
+ * @param m     multi context
+ * @param real  Address to l=
ook up
+ * @return      instance matching the address, NULL otherwise
+ */
=
+static struct multi_instance *
+multi_get_instance_udp_real(struct multi_c=
ontext *m, struct mroute_addr *real)
+{
+    struct hash *hash =3D m->hash;=

+    struct hash_element *he;
+    const uint64_t hv =3D hash_value(hash, =
real);
+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);
+    he =
=3D hash_lookup_fast(hash, bucket, real, hv);
+    if (he)
+    {
+        =
return he->value;
+    }
+    return NULL;
+}
+
+
+/**
  * Get a client ins=
tance based on real address=2E  If
  * the instance doesn't exist, create i=
t while
  * maintaining real address hash table atomicity=2E
@@ -294,7 +316=
,6 @@
 
     if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=
=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
     {
-        struct hash_=
element *he;
         const uint64_t hv =3D hash_value(hash, &real);
      =
   struct hash_bucket *bucket =3D hash_bucket(hash, hv);
         uint8_t *=
ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
@@ -331,17 +352,13 @@
         }
        =
 if (!v2 || peer_id_disabled)
         {
-            he =3D hash_lookup_fa=
st(hash, bucket, &real, hv);
-            if (he)
-            {
-         =
       mi =3D (struct multi_instance *)he->value;
-            }
+         =
   mi =3D multi_get_instance_udp_real(m, &real);
         }
 
         /* w=
e have no existing multi instance for this connection */
         if (!mi)
=
         {
-            mi =3D handle_connection_attempt(m, sock, &real, hv=
, bucket);
+            mi =3D handle_connection_attempt(m, sock, &real, bu=
cket);
         }
 
 #ifdef ENABLE_DEBUG

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-C=
hange-Number: 1725
Gerrit-PatchSet: 20
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--EljBVaS/1zs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #20</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Extract multi_get_in=
stance_udp_real method<br><br>This is just a small refactoring to make the =
code a little bit<br>better organised=2E<br><br>Change-Id: I37ade55d7674c68=
dd98cf4dfde35c4ad42e20d39<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725<br>Message-Id=
: &lt;20260731100844=2E3467-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38096=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpn/mudp=2Ec<br>1 file changed, 25 insertions(+), 8 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/25/1725/20</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/=
src/openvpn/mudp=2Ec</span><br><span>index 2be085f=2E=2E0979002 100644</spa=
n><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mu=
dp=2Ec</span><br><span>@@ -219,7 +219,6 @@</span><br><span> handle_connecti=
on_attempt(struct multi_context *m,</span><br><span>                       =
    struct link_socket *sock,</span><br><span>                           st=
ruct mroute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                          const uint64_t hv,</span><br><span>            =
               struct hash_bucket *bucket)</span><br><span> {</span><br><sp=
an>     struct hash *hash =3D m-&gt;hash;</span><br><span>@@ -250,6 +249,7 =
@@</span><br><span>             mi =3D multi_create_instance(m, real, sock)=
;</span><br><span>             if (mi)</span><br><span>             {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                const uin=
t64_t hv =3D hash_value(hash, real);</span><br><span>                 hash_=
add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span>         =
        mi-&gt;did_real_hash =3D true;</span><br><span>                 mul=
ti_assign_peer_id(m, mi);</span><br><span>@@ -279,6 +279,28 @@</span><br><s=
pan> }</span><br><span> </span><br><span> /**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Looks up an multi instance by its real address=
 (IP and port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram m     multi context</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param real  Address to look up</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return      instance matching the address, NULL oth=
erwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static struct multi_instance =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance=
_udp_real(struct multi_context *m, struct mroute_addr *real)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct hash *hash =3D m-&gt;hash;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D=
 hash_value(hash, real);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    he =3D hash_lookup_fast(hash=
, bucket, real, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (he)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return he-&gt=
;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span>  * Get a client instance based on real address=2E  If</span><br>=
<span>  * the instance doesn&#39;t exist, create it while</span><br><span> =
 * maintaining real address hash table atomicity=2E</span><br><span>@@ -294=
,7 +316,6 @@</span><br><span> </span><br><span>     if (mroute_extract_open=
vpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp;=
 m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        struct hash_element *he;</span=
><br><span>         const uint64_t hv =3D hash_value(hash, &amp;real);</spa=
n><br><span>         struct hash_bucket *bucket =3D hash_bucket(hash, hv);<=
/span><br><span>         uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);<=
/span><br><span>@@ -331,17 +352,13 @@</span><br><span>         }</span><br>=
<span>         if (!v2 || peer_id_disabled)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            he =3D hash_lo=
okup_fast(hash, bucket, &amp;real, hv);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (he)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                mi =3D (struct multi_instance *)he-&gt;value;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            mi =3D multi_get_inst=
ance_udp_real(m, &amp;real);</span><br><span>         }</span><br><span> </=
span><br><span>         /* we have no existing multi instance for this conn=
ection */</span><br><span>         if (!mi)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi =3D handle_=
connection_attempt(m, sock, &amp;real, hv, bucket);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi =3D handle_connection_atte=
mpt(m, sock, &amp;real, bucket);</span><br><span>         }</span><br><span=
> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?u=
sp=3Demail">change 1725</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1725?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1725 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit=
-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--EljBVaS/1zs=--


--===============6667363541469087656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6667363541469087656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6667363541469087656==--


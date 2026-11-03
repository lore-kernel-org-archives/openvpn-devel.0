Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA3606B6E9
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TxhY5ut+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Sq+GqOwN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SRPO0uu0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Pc3y6s/T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=10OQMxOqGoBXPdoN2fw1uzNC3YZP9dGDIqH6xbp1cuk=; b=TxhY5ut+M8Mp3KHP3Tx1aR3y/h
	ij2eiuvDTazcAK3I7Z8qb4gWYnipC/P+81JrJQgoLYfsuSCreu9QzkYDrOd08FhH+3rqFRH/vRrIo
	mpRb/U4L33ZV6YZ2ZbTfGjub5z3M7AaBNyxfLciCuS4DdNSQEXbQ7f08zwZ/+Ip/EJx8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9yt-000000006Cn-1hhO;
	Tue, 03 Nov 2026 08:34:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO9ys-000000006Ch-0tkj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQYLgNCJhWSPTAAlTQMHRbSYFY1xykKLN+tFa7OHDus=; b=Sq+GqOwNK4hqijecJ1GMxXE6e8
 luS/wWuVzvqlB1mpFIm9/03EwANe0cxw10yom6s799t7lH4DJxBpKa5d7GKhiVwdkI1ZcKYB82K3J
 o490cCsKwlhdL9cEArddtsllVj6cwo9gy+9YIDxjiUwl+R902scRLHWj50bwkYzqD4VQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQYLgNCJhWSPTAAlTQMHRbSYFY1xykKLN+tFa7OHDus=; b=SRPO0uu0XYwRzr6EypGvEE4561
 ORSIK5kq22R9+vKuHsI0AzY3nDjcUPr9cl1Qx1rwLX/6DExXbEQDCGGKzYZcltoTD1nbiERx5rbS1
 UeTtw1mcEDV/evfzg6pjv2tqkntg56bk05mQWgkdY2dcT+rpQtWwh/21OKFslOMrGDIQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO9yn-000000003i3-3jlM for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:34:58 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so2014506f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793694887; x=1794299687; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tQYLgNCJhWSPTAAlTQMHRbSYFY1xykKLN+tFa7OHDus=;
 b=Pc3y6s/TkS1qTCHplV2FXn3U+bGD73x+X2CeKiVSB3IgTE4puY3JB3ZR3zqXB1PXFX
 tJ8BGWN61BufxH3+JrSUuF6Y5rvdMQlw7PfnETRfRNYRHGdS+h6xVAj87l2huk3kTUGI
 wjdqlfgbmmdKZhQUcq+ysmLOOyMdt6XQ4wde91t8f66f/MxpOWXqfI40upb2TRGAlHKm
 4MeFL3QJZeZHTLKqTC9zqqK0UJcDjUyPhDAaJbcqQAum0NMvNEVdIkKptQrntX9P0IKa
 b3fqHHTJHsE5+bZmSZgNJ08YUxz3loThnuMrKpnhYSI/G3HJe+fZJThailXmDTJdIW7/
 kmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793694887; x=1794299687;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tQYLgNCJhWSPTAAlTQMHRbSYFY1xykKLN+tFa7OHDus=;
 b=ymm5FAAOftLPvsgOKIQosX4puPYQvUFzVjXeR2STLU61kBP61M+59J9LVwsP2mjLwU
 vgmwyZDjahQ+gWFMP5/E2d9Cw39JBmJtacoLK6X9+bM8qgyaH6xmtGrwIui0ErDnUbFz
 HtJQH0oAwEmdMJ8UoVw8CXO2IBOn8jn9oWSJPYNY1EUDw6c5btREwtsYQ1B9euKVkeAI
 fc3uXSmHZuqVbER6cnSqsmiw89ysVpjrTifO4l/x7nbTdrhZvRkTzRIfo0YhoSiom593
 i0IKhRijJ6M255D9CKxmEEpG2nrQvrJTATiHg9jTOcm+jBaFpn9aNnFDIKFxWpzkHhM5
 +v/A==
X-Gm-Message-State: APuU4Z/MGjbfNQQ9VIOEsYdhN7PgWxcNH3iaBsHp+TFL2lFi4dfOF6ks
 45Bpmu0r/ic9uXQAUaLHU5cYd4+ewj0DaUuEgwiRqi9Q3OkLv+OOr4ZWLbCUkNatj/cNp/slor1
 NfFS6jciwdiScC3AwtHuRhLBXet6TDbT0uj0dGTl+onedyug+t3iVeRrTkVbHKeSO6+bRzOGcQ1
 ZYg3ZtNw==
X-Gm-Gg: AYBFou02P5THqufRF/ob6kZ8jaafscS/u+j+wFnl7OlrRcVibagoTcGkvBmt7VxoDgf
 ZXyafg2xYqRVQ/hL/BGdLRmQg+mEdVze8bP+mw1ZP/dAt1oDgX+DBZwokduY+NTXj5Mnkd5LtGV
 Rze7Vbkp8pkQoMB7D69NypnmtV8dxaoaMWUAyIcX50oEOPfeIgucDZhDwIw0p/gvEuiMXletKYO
 AfNwWCeNl2eCaHFOvmqENUhnTJxaNXbZW9nAEjz2xNrB6s5JL0Zzz30YMMlrHBQj/yVoOs4u7gn
 CBOeSXHKj9HUdcnK6OOG9VruULk6lx2noZKfyq7fic43NXgLPfoF5PPXBc9RmwBGCD8dava8nGw
 1vKVqyVBbB90EvF7oNpSslBDvqigYnkEP4eomfZTCQjDYGiT6Qs1if02awY+84yN4cipr5ksBRF
 CdW+g8Sxnqe4fRYmFMLrnCiMtjDdPO1uIIsGwL8hqbisH/B9/a1iegnNDI8EV2y8J0XCx4vz7BQ
 hMSfy1uPyEmUEo8ptWJE0nhOm7LF+c+QaDH5I8Nfd1Z0tE8GWqIKwYO5n5YuL9MZqdXex2/YdIy
 ko1Cq7ZkM0py/vVm8nTENwiKd0xtPtVR6LN0ihCPYhb/yhmXwr8TxeMzMxA6VfvJV5JIyJSS+QU
 vM8vaOTOZXxZNvAmAI8CZfNcTEf+XtB2EfdvaA6CiOf+/epP/yw32HhIJZteIM1uxj+UyLQ6uhK
 rSecQ4MG5na8rBW4drybEekqTipOJKBQ5Nwcs=
X-Received: by 2002:a05:6000:cc8:b0:48a:fa0a:34d8 with SMTP id
 ffacd0b85a97d-48e6e50a10dmr19971635f8f.38.1793694887105; 
 Tue, 03 Nov 2026 00:34:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9b54dsm23293318f8f.47.2026.11.03.00.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:34:46 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:34:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
X-Gerrit-Change-Number: 2103
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2103?usp=email>
X-Gerrit-Commit: b8db75ff7b316b7f58606f1cef9cfa2d5516de26
References: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjk0ODg0MDAwLkljN2NhNTRkNGUyZWM2Njc1MzJjMDA1MmYxMTBhYWYyZTlhZDViZjgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <55addb11b1cbb5b58ed3620ec7f566802854dfde-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO9yn-000000003i3-3jlM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_epoch: wipe
 key material with secure_memzero()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6018365449763671948=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6018365449763671948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dt7LJ/T4RQY="; charset=UTF-8

--Dt7LJ/T4RQY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2103?usp=3Demail

to review the following change=2E
=


Change subject: crypto_epoch: wipe key material with secure_memzero()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto_epoch: wi=
pe key material with secure_memzero()

CLEAR() is a plain memset(), which t=
he compiler may drop for stack
variables that are not read afterwards=2E Us=
e secure_memzero() for the
derived send/recv data keys and the epoch keys f=
reed in
free_epoch_key_ctx()=2E

Change-Id: Ic7ca54d4e2ec667532c0052f110aaf=
2e9ad5bf82
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src=
/openvpn/crypto_epoch=2Ec
1 file changed, 4 insertions(+), 4 deletions(-)

=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03/210=
3/1

diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=
=2Ec
index 69a1852=2E=2E35f9b55 100644
--- a/src/openvpn/crypto_epoch=2Ec
+=
++ b/src/openvpn/crypto_epoch=2Ec
@@ -181,7 +181,7 @@
 
     init_key_bi_ct=
x_send(&co->key_ctx_bi=2Eencrypt, &send_key, &co->epoch_key_type, name);
  =
   reset_packet_id_send(&co->packet_id=2Esend);
-    CLEAR(send_key);
+    =
secure_memzero(&send_key, sizeof(send_key));
 }
 
 
@@ -196,7 +196,7 @@
   =
  snprintf(name, sizeof(name), "Epoch Data key %" PRIu16, co->epoch_key_rec=
v=2Eepoch);
 
     init_key_bi_ctx_recv(ctx, &recv_key, &co->epoch_key_type=
, name);
-    CLEAR(recv_key);
+    secure_memzero(&recv_key, sizeof(recv_k=
ey));
 }
 
 void
@@ -346,8 +346,8 @@
     free(co->epoch_data_keys_future);=

     free_key_ctx(&co->epoch_retiring_data_receive_key);
     free(co->epo=
ch_retiring_key_pid_recv=2Eseq_list);
-    CLEAR(co->epoch_key_recv);
-    =
CLEAR(co->epoch_key_send);
+    secure_memzero(&co->epoch_key_recv, sizeof(=
co->epoch_key_recv));
+    secure_memzero(&co->epoch_key_send, sizeof(co->e=
poch_key_send));
 }
 
 void

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2103?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
Gerrit-Change-Number: =
2103
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Dt7LJ/T4RQY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">crypto_epoch: wipe key material with secure_memzero()<b=
r><br>CLEAR() is a plain memset(), which the compiler may drop for stack<br=
>variables that are not read afterwards=2E Use secure_memzero() for the<br>=
derived send/recv data keys and the epoch keys freed in<br>free_epoch_key_c=
tx()=2E<br><br>Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82<br>Sign=
ed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/op=
envpn/crypto_epoch=2Ec<br>1 file changed, 4 insertions(+), 4 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/03/2103/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_epoch=2Ec=
 b/src/openvpn/crypto_epoch=2Ec</span><br><span>index 69a1852=2E=2E35f9b55 =
100644</span><br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+=
++ b/src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -181,7 +181,7 @@</span=
><br><span> </span><br><span>     init_key_bi_ctx_send(&amp;co-&gt;key_ctx_=
bi=2Eencrypt, &amp;send_key, &amp;co-&gt;epoch_key_type, name);</span><br><=
span>     reset_packet_id_send(&amp;co-&gt;packet_id=2Esend);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(send_key);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;send_key, =
sizeof(send_key));</span><br><span> }</span><br><span> </span><br><span> </=
span><br><span>@@ -196,7 +196,7 @@</span><br><span>     snprintf(name, size=
of(name), &quot;Epoch Data key %&quot; PRIu16, co-&gt;epoch_key_recv=2Eepoc=
h);</span><br><span> </span><br><span>     init_key_bi_ctx_recv(ctx, &amp;r=
ecv_key, &amp;co-&gt;epoch_key_type, name);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    CLEAR(recv_key);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    secure_memzero(&amp;recv_key, sizeof(recv_key));=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
>@@ -346,8 +346,8 @@</span><br><span>     free(co-&gt;epoch_data_keys_futur=
e);</span><br><span>     free_key_ctx(&amp;co-&gt;epoch_retiring_data_recei=
ve_key);</span><br><span>     free(co-&gt;epoch_retiring_key_pid_recv=2Eseq=
_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(co-&=
gt;epoch_key_recv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  CLEAR(co-&gt;epoch_key_send);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    secure_memzero(&amp;co-&gt;epoch_key_recv, sizeof(co-&gt;ep=
och_key_recv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
secure_memzero(&amp;co-&gt;epoch_key_send, sizeof(co-&gt;epoch_key_send));<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/210=
3?usp=3Demail">change 2103</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2103?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchan=
ge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2103 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>

</body></html>
--Dt7LJ/T4RQY=--


--===============6018365449763671948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6018365449763671948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6018365449763671948==--


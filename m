Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C42606A33D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YExvGhql;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CQn8DRnu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vyvu17HR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YzxE4JFp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6iMTIfoqTZZMt9u5UtZOadUWKNnlIMXfEAyNy1UQcrQ=; b=YExvGhqlZOm8VPThhl/k1sZV0/
	QAUpupfObFzmj/krPBE2OU+P9cGooqOii8mlE2KHrfCzM7HBdC+kw/fydMNGlOqLggWrrxulPPrV5
	q1IFszppYrlalUB1SA2Yz9NjwMqcCBTArWJ+YhNBSek7IHHbwT3EbjJUQD34N/ObZ44k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOMLb-000000005zQ-2LBZ;
	Tue, 03 Nov 2026 21:47:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOMLZ-000000005z3-2s3B
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5tL6/piylVk7UDv5b+8kge0SmA8OEuE7YA16zrb5o0A=; b=CQn8DRnuyDm7Q95vfTmquQY01K
 3LuvdyQNWXO5Ps5EI5TzurTvaeA50n/T7k9HylvkOhGAMs4oOlBIOqveeoQx94vtV8ftXsNcZ0gjN
 TUfwND71vqqsLmN6pT6Vi/BdRUI/s81IhgjJ24qNi+fA9InL0O/Uz9lDWd66u36qyjNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5tL6/piylVk7UDv5b+8kge0SmA8OEuE7YA16zrb5o0A=; b=Vyvu17HR2jZ+Kjgm26257mvRnu
 exbVB0SrulI7bFWpQq70XfsrIDlYJsvL576czBKzb1K0AQ4WgM/uas9SEjNMdgbxgb7r7Np6IXGDW
 2G6dd9+GC3Rf0xolnje5wQGjHJXcZVLXrijGyGgDKXbs4RhoRIfacOeDMUkYrDwQBoTw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOMLM-0000000010x-16iN for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:47:01 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so56379f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 13:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793742414; x=1794347214; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5tL6/piylVk7UDv5b+8kge0SmA8OEuE7YA16zrb5o0A=;
 b=YzxE4JFppjSE56IuiVohKvSdHulU6SLlOds0IMaqgkysxc7VvO37EPtYbr7jqfjiAB
 2JQP23ocY2+iik0Ma6ATVUw8MfpDnIEoJ33PEVqzzENyFH1hWGlUtb8FDVSR86KQa0QI
 mgDbwR0RT/XNLeYxCOigbUeS1VHmqtjGcvTENWtDDiYN45wrxbRzbpbdS5gnxARBf9fU
 06fBzY+vkd3+5durf+c1swT/ZFW+Mi5ch0EqDWgp853hW/ajhiD9g+gFPNIIaVJjzBXw
 zSJktrh8TcczO0vmuZVmUTCRoJhvb/8CuSXBsV6cp2Jcns+ytmsB/tjd8JfXzWJl3HV8
 dKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793742414; x=1794347214;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5tL6/piylVk7UDv5b+8kge0SmA8OEuE7YA16zrb5o0A=;
 b=umf9rz77ms41rfpaIvvfPYVEFoor71cxoaU8Eov05RdcQd27aB/ChEh17kL/SOJM0T
 NGTNBIGvaIL06LvhCPYSxwgRRLURa5xmcIWHaG9412F3YEqeHhRMOiLnj+99TYN265Ue
 ia6f8fKizV6kWjc+PJlhD5nH+fnAbRd4N2GDtPa7piIHJ+kyOnqW/tKetA74npTQ1U2A
 Dy8oAxChz+DDRKy8hHDM26lmeUj+offA2gSbgcZbrsk5cEsrbpvE1ERF7JJ5WDCGcxuC
 TBuiH8YQS6Px9ZtroTI/i7S4kIV0Xgo9Iz5/C1bryfYl8t/w2+yEB+NJ7RQ082jgxrBT
 SNtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVIIkLsEIJLBkOvltPNcMolHU6G6nzeC4+4tOWkA6GOayV7D88tg9FQjhZu9NKWCr4K6Pjo6dIIMLEFpBh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z98AZAWBB1FOq2kFBYRehMnbD4cLAYDM24zz5fdyaNMxulPzugN
 Vf02F6RVkBp3N4RxpLuoSlymC5OvR6K+TRfG6Lis4PsMSTQUp2KVUqzAIIhW3Qd8egeMzR+Xkvh
 sa+SeIAVMSpHdYY9FhwH/xuqVn4O+B1gRTpNF/KhxJqoBa5HPGGqiyypb1hAa3KJpOLlHpyom0v
 MbhG5JQA==
X-Gm-Gg: AYBFou07Zm/ewfg84S/blgu4ysfWXHpqdn/OgUmks4hQ5mhu8yfAJVTKUyBvZq0ZFmZ
 cEaI3BmUpKhieLvScm3GkdCct7u9TvkhzwG7xGuuYFyauxtyGaUYJVRfZCvICuOt0F+mdHr9mRG
 uq5FKGAOI19r1oOyoQke39jAeAXQ7BLI6EJEg2q0hEpgMFMh6AN5PJckmpk3J8SMHhai7s5pmid
 BqRI+Om0W6kSLiFn6Vf1L1PHVvheQJGQzr1N75bzLU54GHTBZMG4Z1H5tvlc+Ow/LcEZMlPjo70
 cQ0gS1+wmhDGnFaYyPhuOEbgQ535BS2clD0edWgo/B1FZ0mtwaG8oWmlD11LgWfZYNLZCSZI3lw
 JNeZxl48UtsnrxUzD1Ctvhe5DIZd8jARCrIqAPaJKameGWKIqoJFX2FHbevUH155MweeNOCBpmK
 4/umuPSybBW5WyvpPJJz030cYc0ha8yXtmd7Lq3aVfAVTulM2f/dO/fwi6aU+ICdpaAs+tlrjXj
 SPzs4SFPbmUp3NrJCRthkxrFewTYlp8NabQZNRwu5NqCE8OT5O2fuHOwynCxD9q2P0MAZDdov1R
 eoAEnM8EHHaBJZbp2asFlBCWaQwmoEeDs6u4OIqMKC31q5HZj6zkF0bQ0vOyUHl6CkzQC/gmrL1
 VEvMNo4o4UxUWrn/jY47FMdst8CBixMuuEVCIwXuf5o+7SRwDJZRQiYYRVowfpAXOkcyRtdGMYL
 j7/Cg77z/TzeiWBg==
X-Received: by 2002:a05:6000:4914:b0:48c:69b3:610f with SMTP id
 ffacd0b85a97d-48e6e5008b4mr31130756f8f.26.1793742413655; 
 Tue, 03 Nov 2026 13:46:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08514fsm229522f8f.31.2026.11.03.13.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:46:53 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 21:46:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
X-Gerrit-Change-Number: 2103
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2103?usp=email>
X-Gerrit-Commit: f1721dc7c1c0eb7e257ec557d86e7ec38599586a
In-Reply-To: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
References: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjk0ODg0MDAwLkljN2NhNTRkNGUyZWM2Njc1MzJjMDA1MmYxMTBhYWYyZTlhZDViZjgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e44881171ab5324b46e9e0b3244ce82fb9470752-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOMLM-0000000010x-16iN
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6462218300017154825=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6462218300017154825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YuEXlSrs1uI="; charset=UTF-8

--YuEXlSrs1uI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2103?usp=3Demail )

Change subject: crypto_epoch: wipe key mate=
rial with secure_memzero()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

crypto_epoch: wipe key material with secure_memzero()

CLEAR(=
) is a plain memset(), which the compiler may drop for stack
variables that=
 are not read afterwards=2E Use secure_memzero() for the
derived send/recv =
data keys and the epoch keys freed in
free_epoch_key_ctx()=2E

Change-Id: I=
c7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
Signed-off-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103
Message-Id: <20=
261103124012=2E4642-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40570=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto_epoch=
=2Ec
1 file changed, 4 insertions(+), 4 deletions(-)




diff --git a/src/o=
penvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 69a1852=2E=2E3=
5f9b55 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_e=
poch=2Ec
@@ -181,7 +181,7 @@
 
     init_key_bi_ctx_send(&co->key_ctx_bi=2E=
encrypt, &send_key, &co->epoch_key_type, name);
     reset_packet_id_send(&=
co->packet_id=2Esend);
-    CLEAR(send_key);
+    secure_memzero(&send_key,=
 sizeof(send_key));
 }
 
 
@@ -196,7 +196,7 @@
     snprintf(name, sizeof(n=
ame), "Epoch Data key %" PRIu16, co->epoch_key_recv=2Eepoch);
 
     init_k=
ey_bi_ctx_recv(ctx, &recv_key, &co->epoch_key_type, name);
-    CLEAR(recv_=
key);
+    secure_memzero(&recv_key, sizeof(recv_key));
 }
 
 void
@@ -346,=
8 +346,8 @@
     free(co->epoch_data_keys_future);
     free_key_ctx(&co->e=
poch_retiring_data_receive_key);
     free(co->epoch_retiring_key_pid_recv=
=2Eseq_list);
-    CLEAR(co->epoch_key_recv);
-    CLEAR(co->epoch_key_send=
);
+    secure_memzero(&co->epoch_key_recv, sizeof(co->epoch_key_recv));
+ =
   secure_memzero(&co->epoch_key_send, sizeof(co->epoch_key_send));
 }
 
 v=
oid

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic7ca54d4e2ec667=
532c0052f110aaf2e9ad5bf82
Gerrit-Change-Number: 2103
Gerrit-PatchSet: 2
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--YuEXlSrs1uI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2103?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">crypto_epoch: wipe key material wi=
th secure_memzero()<br><br>CLEAR() is a plain memset(), which the compiler =
may drop for stack<br>variables that are not read afterwards=2E Use secure_=
memzero() for the<br>derived send/recv data keys and the epoch keys freed i=
n<br>free_epoch_key_ctx()=2E<br><br>Change-Id: Ic7ca54d4e2ec667532c0052f110=
aaf2e9ad5bf82<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103<br>Message-Id: &lt;20=
261103124012=2E4642-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40570=2Ehtml<br>=
Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src=
/openvpn/crypto_epoch=2Ec<br>1 file changed, 4 insertions(+), 4 deletions(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/=
crypto_epoch=2Ec</span><br><span>index 69a1852=2E=2E35f9b55 100644</span><b=
r><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvp=
n/crypto_epoch=2Ec</span><br><span>@@ -181,7 +181,7 @@</span><br><span> </s=
pan><br><span>     init_key_bi_ctx_send(&amp;co-&gt;key_ctx_bi=2Eencrypt, &=
amp;send_key, &amp;co-&gt;epoch_key_type, name);</span><br><span>     reset=
_packet_id_send(&amp;co-&gt;packet_id=2Esend);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    CLEAR(send_key);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    secure_memzero(&amp;send_key, sizeof(send_key=
));</span><br><span> }</span><br><span> </span><br><span> </span><br><span>=
@@ -196,7 +196,7 @@</span><br><span>     snprintf(name, sizeof(name), &quot=
;Epoch Data key %&quot; PRIu16, co-&gt;epoch_key_recv=2Eepoch);</span><br><=
span> </span><br><span>     init_key_bi_ctx_recv(ctx, &amp;recv_key, &amp;c=
o-&gt;epoch_key_type, name);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    CLEAR(recv_key);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    secure_memzero(&amp;recv_key, sizeof(recv_key));</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span>@@ -346,8 +346=
,8 @@</span><br><span>     free(co-&gt;epoch_data_keys_future);</span><br><=
span>     free_key_ctx(&amp;co-&gt;epoch_retiring_data_receive_key);</span>=
<br><span>     free(co-&gt;epoch_retiring_key_pid_recv=2Eseq_list);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(co-&gt;epoch_key_re=
cv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(co-&gt;=
epoch_key_send);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 secure_memzero(&amp;co-&gt;epoch_key_recv, sizeof(co-&gt;epoch_key_recv));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(=
&amp;co-&gt;epoch_key_send, sizeof(co-&gt;epoch_key_send));</span><br><span=
> }</span><br><span> </span><br><span> void</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?usp=3Demail">=
change 2103</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/210=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2103 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--YuEXlSrs1uI=--


--===============6462218300017154825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6462218300017154825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6462218300017154825==--


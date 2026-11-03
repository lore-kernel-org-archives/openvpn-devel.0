Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C8606A334
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i6W1kpZ4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CWkCMj7G;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YR2Q2nfT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PYWKrDe0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=spHNWPox0wFllrD4p9fV5wr0nRF8i882+X3zEjURypE=; b=i6W1kpZ4AqgPXivA9ofthUvnjj
	nPagrY+MU2sI35f5phQmjN1yaC9fyNKbFWwE8g3sujNXvrJGBwtnyki8g5PvusH9OrwgWaI6ZJfQe
	bG7i9HHhuPEyPitp+LnDEbph6dekYbPYEbH4ChVofXdYb/R6LlzxTwgkOjONaw0I0F7c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOMLa-000000007jD-3Mgd;
	Tue, 03 Nov 2026 21:47:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOMLZ-000000007iq-2rrE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KMy6d+1Y+iTkve8lZFkjF45yiJuu+rZtTLRRUT6d7Jo=; b=CWkCMj7GAChX3t5XBXoHRxPayE
 fHOM7uldsdDARhNzD+USrkHBUp/BS2Z4+LNZ87M0mh2fll8SsLWF53Vv/jn6UrZZkXwAdADuiovFA
 gqBIofHTgK9qlawXaZnfG8Azh6WTcoq9vqcrdoeJn+5baA9K9LgAOYL0zgHpe125j4w4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KMy6d+1Y+iTkve8lZFkjF45yiJuu+rZtTLRRUT6d7Jo=; b=YR2Q2nfT1DIN+bXyKMuh9lX5oT
 Sbhh5PRIZ8IPvZBA3PT1GUMnhBCIxUA55Rmp4Dis6TCn4C4lBvhTfRN/JDkIOVSwLeRWCm0bAHJMy
 NyuEEvFfhbX+xxW5ZmxhAX38RgJkM7sXSf2wjIU5yuG+bRMDjkhdUzFKq7/cfWfoXDY8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOMLL-000000007e3-1Y7E for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:47:00 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso235615e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793742413; x=1794347213; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KMy6d+1Y+iTkve8lZFkjF45yiJuu+rZtTLRRUT6d7Jo=;
 b=PYWKrDe0axJZIMHGnw2FcTyNK7lkDWSLDp7umzAoIdPh77yo+4GucaKaEoUBf4Pr1c
 vhTn79QQmd6y1OuyybCH2QR3sXOM6IB6e0fUkgK8CkO/PqVDNqRc4NqWmz10VWMob/ce
 IqjmTfL47y0XnFy3zGGmE+i76ks9nINODWiOQtWWo+iQsji8fYOBEdKY9NDfKAUXe8WD
 uaguqr9/blZlX2rvm4wqUQKO32JoEXnm4fbbxMvSd1Ungxe4RHqJRUDqhHtRIx644oe+
 COikMvUX8RyYnc/ivbhFw1REaUsMnPxQtzujKEpkZWW+Qw+Eod/zCJIdKsS8O86aXVG7
 azzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793742413; x=1794347213;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KMy6d+1Y+iTkve8lZFkjF45yiJuu+rZtTLRRUT6d7Jo=;
 b=qtoIQfFRrwn4KKjWKHD7Y0QJpC2KA57J4lo/BMYDY8JaHpyoujWcJYV66dKoj7kA6z
 A+fYPkwROMSTMtts4dRggDv7de9loqSRO40M52YlP6CAkILAY+WzXz2krGAbd0iizu0f
 4u+SltwVHFaqHbFH+Z6vTeEr+kw8ePWzssej/s8vdiEYEwLSKanXmDMsdbLK/sTBXwTT
 Z8g4ClpHcCRr/lyWSatjI1t7Px5OeUYjmNO8AA7yK/0vmZ+H06sVyKgbTMUmINXbjOXj
 9FCUGwF9iKBkTJL1if3YaFgDzAwwi2jo3x4t1a6UBWXEvpQUO/giNdIp+LfJsDiQvciM
 /ZXw==
X-Gm-Message-State: APuU4Z+LGEI1gGTHfJsZhK7eNiRStDT8DW4OyUvKDEgpAHMH9dd7LD11
 x/MeSxrvSdknLHpah8vPjhn6303uMRGNDUCfXg0+p3h3IZv9OpB3YdPwYWCOfYTb8jqk3qoaxgR
 LkQSB6EZfJPs7L0+lOjA8yn0HDBNoaYCwGJnQzaQTdr81LTilIzpb/sjtzX9mL9a24+Mx
X-Gm-Gg: AYBFou0HhVm/gKBJljTbQMMDtsWZEpnYRjT6s7Wc3OXc/m6Fb8x+Bc0yuYd3Kvm4fC1
 8iXSkxCNP+yMKLc0X5VncB3STCSSeMfi3b9FjctPiSnAVM516JPla82+qEu1FTT3LyqAqBQRM22
 ac1VNeI9tlvWLf2JZqfgb15J40kt6uBazGHUbn9Wdx75O7QSPzP08Uye5JVd7p2OlTF6P5wZxcW
 /FdXcNgUYDQb3TuUvJniYNtn44TW6mCSKDsdCp8IXQhd03SkYGZwxf1nw/HgsLVvV2Zp19ym+uj
 E4b5iWKBsdMqeVdHm5bHmL1mkiNtSwe1kDaLCJt+/aV8gVHHrQszRxoPViw3OESxVJXjNFrSnxS
 7qsnQLdz8FlTPNIBHxXoPkU9qa9nSMrPDekhsmM//cgRMVG5hqUyXagRfvO7AocY5jifofAHMaj
 2Rh1QYXpJBeq306LJCjW7K3pA3bbPkJix4rFaIRamh99idWvkL14Ty5L6F2gP0O+o/8uLK/Rk7u
 Jj0+KA1EoIN2lpVtL3ALIMACowZzlgxI6LIEcooUbLgjRoIw1t+tI8iQtLB9gMxNcohXow1EIAD
 iA9RZAfzdmilVobsq9SJL/lgNkHeiE9b1MNW44ny6xkb4vK8npDKDxBtbKAsZPj9NF4D60qlUNi
 R4ntoY6SI+iMNTB+xLaZjYSvYRpn7aGoMDlVKzC6LgZFvuD9u/72lPegM8Ux1jz3l5vhmfqd3me
 MGpILI8rehBTMkSUQXiMBqFmubvKjop4XFsn4=
X-Received: by 2002:a05:600c:3b2a:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4ac14fbdd04mr328664405e9.4.1793742412652; 
 Tue, 03 Nov 2026 13:46:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecf8ef85sm228571f8f.27.2026.11.03.13.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:46:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 21:46:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
X-Gerrit-Change-Number: 2103
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2103?usp=email>
X-Gerrit-Commit: f1721dc7c1c0eb7e257ec557d86e7ec38599586a
In-Reply-To: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
References: <gerrit.1793694884000.Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjk0ODg0MDAwLkljN2NhNTRkNGUyZWM2Njc1MzJjMDA1MmYxMTBhYWYyZTlhZDViZjgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e44881171ab5324b46e9e0b3244ce82fb9470752-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOMLL-000000007e3-1Y7E
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3189722166904017543=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3189722166904017543==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DYRJbTZLsMc="; charset=UTF-8

--DYRJbTZLsMc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2103?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: crypto_epoch: wipe k=
ey material with secure_memzero()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

crypto_epoch: wipe key material with secure_memzero(=
)

CLEAR() is a plain memset(), which the compiler may drop for stack
varia=
bles that are not read afterwards=2E Use secure_memzero() for the
derived s=
end/recv data keys and the epoch keys freed in
free_epoch_key_ctx()=2E

Cha=
nge-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
Signed-off-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103
Messag=
e-Id: <20261103124012=2E4642-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40570=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/cry=
pto_epoch=2Ec
1 file changed, 4 insertions(+), 4 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03/2103/2

diff --g=
it a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 69a1=
852=2E=2E35f9b55 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvp=
n/crypto_epoch=2Ec
@@ -181,7 +181,7 @@
 
     init_key_bi_ctx_send(&co->key=
_ctx_bi=2Eencrypt, &send_key, &co->epoch_key_type, name);
     reset_packet=
_id_send(&co->packet_id=2Esend);
-    CLEAR(send_key);
+    secure_memzero(=
&send_key, sizeof(send_key));
 }
 
 
@@ -196,7 +196,7 @@
     snprintf(name=
, sizeof(name), "Epoch Data key %" PRIu16, co->epoch_key_recv=2Eepoch);
 
 =
    init_key_bi_ctx_recv(ctx, &recv_key, &co->epoch_key_type, name);
-    C=
LEAR(recv_key);
+    secure_memzero(&recv_key, sizeof(recv_key));
 }
 
 voi=
d
@@ -346,8 +346,8 @@
     free(co->epoch_data_keys_future);
     free_key_=
ctx(&co->epoch_retiring_data_receive_key);
     free(co->epoch_retiring_key=
_pid_recv=2Eseq_list);
-    CLEAR(co->epoch_key_recv);
-    CLEAR(co->epoch=
_key_send);
+    secure_memzero(&co->epoch_key_recv, sizeof(co->epoch_key_r=
ecv));
+    secure_memzero(&co->epoch_key_send, sizeof(co->epoch_key_send))=
;
 }
 
 void

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2103?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic=
7ca54d4e2ec667532c0052f110aaf2e9ad5bf82
Gerrit-Change-Number: 2103
Gerrit-P=
atchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>

--DYRJbTZLsMc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2103?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">crypto_epoch: wipe key material with secure_memzero()<br><br>CLEAR() is=
 a plain memset(), which the compiler may drop for stack<br>variables that =
are not read afterwards=2E Use secure_memzero() for the<br>derived send/rec=
v data keys and the epoch keys freed in<br>free_epoch_key_ctx()=2E<br><br>C=
hange-Id: Ic7ca54d4e2ec667532c0052f110aaf2e9ad5bf82<br>Signed-off-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2103<br>Message-Id: &lt;20261103124012=2E4642-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40570=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto_epoch=2Ec<br>1 file=
 changed, 4 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03/2103/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec<=
/span><br><span>index 69a1852=2E=2E35f9b55 100644</span><br><span>--- a/src=
/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2E=
c</span><br><span>@@ -181,7 +181,7 @@</span><br><span> </span><br><span>   =
  init_key_bi_ctx_send(&amp;co-&gt;key_ctx_bi=2Eencrypt, &amp;send_key, &am=
p;co-&gt;epoch_key_type, name);</span><br><span>     reset_packet_id_send(&=
amp;co-&gt;packet_id=2Esend);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    CLEAR(send_key);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    secure_memzero(&amp;send_key, sizeof(send_key));</span><br><sp=
an> }</span><br><span> </span><br><span> </span><br><span>@@ -196,7 +196,7 =
@@</span><br><span>     snprintf(name, sizeof(name), &quot;Epoch Data key %=
&quot; PRIu16, co-&gt;epoch_key_recv=2Eepoch);</span><br><span> </span><br>=
<span>     init_key_bi_ctx_recv(ctx, &amp;recv_key, &amp;co-&gt;epoch_key_t=
ype, name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(=
recv_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secur=
e_memzero(&amp;recv_key, sizeof(recv_key));</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span>@@ -346,8 +346,8 @@</span><br><=
span>     free(co-&gt;epoch_data_keys_future);</span><br><span>     free_ke=
y_ctx(&amp;co-&gt;epoch_retiring_data_receive_key);</span><br><span>     fr=
ee(co-&gt;epoch_retiring_key_pid_recv=2Eseq_list);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    CLEAR(co-&gt;epoch_key_recv);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(co-&gt;epoch_key_send);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&=
amp;co-&gt;epoch_key_recv, sizeof(co-&gt;epoch_key_recv));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;co-&gt;epoch=
_key_send, sizeof(co-&gt;epoch_key_send));</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?usp=3Demail">change 2103</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2103?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic=
7ca54d4e2ec667532c0052f110aaf2e9ad5bf82 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2103 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--DYRJbTZLsMc=--


--===============3189722166904017543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3189722166904017543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3189722166904017543==--


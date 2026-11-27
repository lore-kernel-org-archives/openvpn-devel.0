Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C07606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A0RYjDCF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OJgxkQVO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ae7Mz1ZX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VBCRfIlC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Loa0ROFTEdGlXd04M7qn+DCsIojXPGbYgAvDqH2a8sA=; b=A0RYjDCFaY6b78Wr09b6BXTu5h
	TxRuuyJtp/m58dXmExi89VcnCXpwPIlS2JWxd2/tr1wwKE3oJuIzdYznYu7Z883ivQL/qmknarcRK
	55Kh9TQg//tuUQqZNDuXdMV+P1F2KqLP26XLxxWrgKmyp3nQNozceDEZjgzn6+NKlJuY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX4SG-000000004Iy-0pJI;
	Fri, 27 Nov 2026 22:30:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX4SE-000000004Is-2ogx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dZWI3fmg1azMwV7NIWbpA0LZdZABwtKYRK74r+VTo2U=; b=OJgxkQVO5CMiIa4P7rsAoRebNp
 GMyVm2dARTLbFjHXkYBCvT0d4ZEd0nwom44ZurUqjFIlkTpOymd9MWNkRdnob0EPmObHHbyVD9n3M
 efljoGeW/DKQHAyQpWN6qC9KfvW7wkYy4xUJqp5gLR+Da01wWjcV83QdyMr8M4Bi49PU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dZWI3fmg1azMwV7NIWbpA0LZdZABwtKYRK74r+VTo2U=; b=Ae7Mz1ZXdSoeCmzBGl2wsMXLix
 lUiCGFeCWH83e/cEHpDVnsNnyTzmdbF5FvuXYOMHRLLD96W8NupnAmsv7x1MJE9SpSTIS3zgq38Yn
 CLP33tjc0ds3FaRhAlI8xgF90vGtl2W+y/MGZ631yqmKpCCikHl8Dh51Aq3EEfGRHdUw=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX4S2-0000000074E-3P6E for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:30:06 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so53107825e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795818588; x=1796423388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dZWI3fmg1azMwV7NIWbpA0LZdZABwtKYRK74r+VTo2U=;
 b=VBCRfIlCSh2vTlDRzfzo3c4Psk1imd027KGRRSQAHaOUBML9Fibj6aQtNBnBj1KYiX
 odAATOzRdX1s0k91YM7pfVicNZ04Mg8HiGDa9j1/1OyOQbqbtvDPsMprcRXjpEC3g94d
 jJG78vs19sh+pE+svB7EO9xhApWnVRhM0yu93HNsCa++NQbokbn2PfG3I9CxnXMVNzUC
 OGs878zqRwdvXoCLXSXoJKxHv3dcesDE7OW3gqePmzqaP2PRGVOruLoP+QQ9OerPi1Mz
 B67qbNR3fV8ubk8TjbAKjKG3+WM46+Y+1JvddGMq1LBA1IIno0SmggTtZjb45oSdySqV
 1+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795818588; x=1796423388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dZWI3fmg1azMwV7NIWbpA0LZdZABwtKYRK74r+VTo2U=;
 b=gF4TSfkpPPVAbd9kbKLFO8miKZzpFl0sXdzcFg9b1ugUQqz9vPOKA1Ip8um1KRn9Nh
 DzrAhxIsapd2HzbhPM9bIQXBCqElVP7vcfiF+CcpKbWtvIhHs4yeWT2r/ZqO33CTJ3yF
 GQ622kBWpjxkhw4Me0raavUJk4Hy1iyqNgZ9dKzAVhTT3KaS6pVMuI+3Ptjc4zMSkeo6
 8GCmusWT3Wqa6wxJRvi/l1i/hT6meeX77Qk1VDu6oPM7iSaq7L2OuiqNdfkn5XBoNsoY
 hIQNOGuFYCZKKD7UOz+m3ytmlqPuQxJCxVNmxlOQPhXqSiFiBT8GnsnKSHlFkqj/j8pp
 5Jmw==
X-Forwarded-Encrypted: i=1;
 AL+hErFc+rdpQlJ5kXY78NaVZbTpmVecpt598eihLg86tC2VTx3me1H+VTod2KwTQCv4PcfaZDyRUJ66eg4YreN9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9cVHfciZZlGBJcid/3wt4D8JoLzQLjcNC+dCx/+uAu3rUaD+8e
 vMtuLi3OdlFAAKg81cgDw0Dl3FQdYD8FPSWitfD/4niKWmfz/Ci1kst+LsIrUZOnjihEsxo5ePG
 iGm1FGHG9psBtXMWhjNr24ztXVaI4SEV/ey9jB3PMek9sDLeWbRw5PNjEbAHQxqqUbfIP
X-Gm-Gg: AZFdTZcejShO5NCwLHhzEh7162iaPWP6OmLuaTvZXu1o269vsUYFwf42pnANcOHpm7q
 oWX0/gD2mdKI8QyycUZadhVgmswVO9DDDD+RIWhIe0vrO8b6rs5Kdr4nziO1uQziitV2zr6DrRK
 dgeMYZfdRP4oLT3Inh3pfYIm2ja3oXDn0S/CilQFsmyxS1fXNFqZRjaQ2TkAngQQHIYBeeUUv4b
 H7CxqBwTBsEIhitdzlOafcWr6JmDDT9ePHZ0QRLxqF48XEfH8BTq5EJJStDSWBMTzxh7O4nIvTp
 hwXU+biVEKjUbxNuT3ooh0VHSIUO9R+Nbtt3s4aHP7284XWQS2CD4qzBUn0uypNN2bMliehSESC
 F2LyADZT884kphqJqgtNPV6/y4DLtXce8fj5Z7dKMri5fqaLICUSsRpPH+JlHHg8poz03tYc1Z6
 YvbJjloO5DoWYXldsF0v24gBqcgnMuInWRZnR7rEm4b7jwWP6xVxMzPqZwdl+mRTTIACUV85LlZ
 prRRakodNjy30Od30NONaamrwDlltsX7kwzjbWew3Uv7ZYjUzSJJqmWNWw4B96B5hF/HTLETRFC
 NEtv98v/a4YcwYkATzOxF8EFru1unJyUnFsRH+UZm4DRXs3OwEUQPnONGT1hqi+AAmvuq83s4nE
 IesljWW8yqaBbxIN348B8wYzKC9dAI5IXahaM5beiQKY272hmcdZSdU/M/GaIrCeXtGC44lBUqP
 mq1fcx85+Zm33CldA=
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4bb887fc396mr531578855e9.3.1795818587766; 
 Fri, 27 Nov 2026 14:29:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm718224285e9.10.2026.11.27.14.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:29:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 22:29:47 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 418d24e158329342b385c65d9b0bab14dd645d91
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b4ac64d0278901d5d5b3001b5dbc98721d2b1ba-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX4S2-0000000074E-3P6E
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0833246332369813329=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0833246332369813329==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5hvcIFOrykU="; charset=UTF-8

--5hvcIFOrykU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1741?usp=3Demail )

Change subject: control_msg: Add P_CONTROL_=
V2 and the probe request and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_msg: Add P_CONTROL_V2 and the probe re=
quest and reply TLVs

A client probes a server before connecting by sending=
 a P_CONTROL_V2
message carrying a probe request TLV, and the server answer=
s with a
P_CONTROL_V2 carrying a probe reply=2E The reply tells the client =
how the
server wants to be ranked against the other remotes, and can also s=
erve
as the second packet of the three-way handshake=2E

Add the two opcode=
s and the two TLV codecs the probe needs=2E P_CONTROL_V2
is framed like P_C=
ONTROL_V1 but without the fields of the reliability
layer: a session id and=
 then the TLVs, with no control message id and no
ACK array=2E P_CONTROL_WK=
C_V2 is the same with the wrapped client key
appended, as P_CONTROL_WKC_V1 =
is to P_CONTROL_V1=2E

The TLVs use the shared TLV codec, control_msg=2Ec/h=
, and their two types
join the others there=2E The codec gains ctrl_msg_fin=
d_tlv(), which scans
a payload for the one mandatory TLV of a message=2E Th=
e scan is strict: a
truncated TLV header or value, a second TLV of the want=
ed type, or an
unknown TLV not marked optional rejects the whole message=2E=


Both readers accept a value longer than the fields they know and ignore
t=
he excess, which is how the TLVs are meant to be extended=2E The probe
repl=
y reader does reject the two flag combinations the protocol rules
out, as n=
either can be acted on: the other addresses of a remote cannot
be both the =
same server and distinct ones, and the connect_lifetime
cannot be extended =
to those addresses without first calling them the
same server=2E

The relia=
ble control path no longer decides what it handles from an
opcode range=2E =
P_FIRST_OPCODE and P_LAST_OPCODE give way to
opcode_is_reliable_control(), =
which lists the opcodes that carry a
message id and an ACK array, and tls_p=
re_decrypt_verify_opcode() and
write_control_auth() test that instead=2E De=
fining an opcode therefore no
longer joins it to that set, so the two opcod=
es added here need no
carve-out from a range=2E

No opcode changes hands: t=
he old range covered exactly the seven listed,
plus the two data channel op=
codes, which are handled before the check is
reached=2E

The probe is not s=
ent or answered yet; that follows=2E

Change-Id: I1c8d302ac57c5603d622a7be1=
4be369437388268
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741
Message-Id: <20261119130414=2E20274-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41678=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openv=
pn/control_msg=2Ec
M src/openvpn/control_msg=2Eh
A src/openvpn/probe=2Ec
A =
src/openvpn/probe=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src=
/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_=
tests/openvpn/test_pkt=2Ec
A tests/unit_tests/openvpn/test_probe=2Ec
A test=
s/unit_tests/openvpn/test_probe=2Eh
13 files changed, 860 insertions(+), 12=
 deletions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 50=
b2d68=2E=2Ec6dcf65 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ =
-565,6 +565,8 @@
     src/openvpn/plugin=2Eh
     src/openvpn/pool=2Ec
    =
 src/openvpn/pool=2Eh
+    src/openvpn/probe=2Ec
+    src/openvpn/probe=2Eh=

     src/openvpn/proto=2Ec
     src/openvpn/proto=2Eh
     src/openvpn/pro=
xy=2Ec
@@ -899,7 +901,9 @@
     target_sources(test_pkt PRIVATE
         te=
sts/unit_tests/openvpn/mock_win32_execve=2Ec
         tests/unit_tests/open=
vpn/test_control_msg=2Ec
+        tests/unit_tests/openvpn/test_probe=2Ec
 =
        src/openvpn/control_msg=2Ec
+        src/openvpn/probe=2Ec
        =
 src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn/=
crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makef=
ile=2Eam
index be1044d=2E=2E4c8edea 100644
--- a/src/openvpn/Makefile=2Eam
=
+++ b/src/openvpn/Makefile=2Eam
@@ -121,6 +121,7 @@
 	ping=2Ec ping=2Eh \
 =
	plugin=2Ec plugin=2Eh \
 	pool=2Ec pool=2Eh \
+	probe=2Ec probe=2Eh \
 	pr=
oto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
diff --git a/=
src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
index e14355c=2E=
=2Ea77413f 100644
--- a/src/openvpn/control_msg=2Ec
+++ b/src/openvpn/contr=
ol_msg=2Ec
@@ -91,3 +91,32 @@
     buf_set_read(value, v, hdr->value_len);
=
     return true;
 }
+
+bool
+ctrl_msg_find_tlv(struct buffer *payload, uin=
t16_t wanted_type, struct buffer *value)
+{
+    bool found =3D false;
+   =
 while (BLEN(payload) > 0)
+    {
+        struct ctrl_msg_tlv_header hdr;
=
+        struct buffer v;
+        if (!ctrl_msg_tlv_next(payload, &hdr, &v=
))
+        {
+            return false;
+        }
+        if (hdr=2Etype=
 =3D=3D wanted_type)
+        {
+            if (found)
+            {
+   =
             return false; /* the TLV may occur only once */
+            }=

+            *value =3D v;
+            found =3D true;
+        }
+      =
  else if (!hdr=2Eoptional)
+        {
+            return false; /* a mand=
atory TLV we do not understand, wherever it sits */
+        }
+    }
+    =
return found;
+}
diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/con=
trol_msg=2Eh
index 92572cb=2E=2E8ad5530 100644
--- a/src/openvpn/control_ms=
g=2Eh
+++ b/src/openvpn/control_msg=2Eh
@@ -41,6 +41,8 @@
 
 /* TLV types *=
/
 #define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the res=
et packets */
+#define TLV_TYPE_PROBE_REQUEST   0x0002 /* a client probing =
a server, in P_CONTROL_V2 */
+#define TLV_TYPE_PROBE_REPLY     0x0003 /* th=
e server's answer, in P_CONTROL_V2 */
 
 /* A TLV header is a 16-bit type/o=
ptional field plus a 16-bit length */
 #define CTRL_MSG_TLV_HEADER_LEN 4
@@=
 -105,4 +107,28 @@
  */
 bool ctrl_msg_tlv_next(struct buffer *buf, struct =
ctrl_msg_tlv_header *hdr, struct buffer *value);
 
+/**
+ * Scan payload fo=
r the TLV of type wanted_type, skipping any other TLV type
+ * that is mark=
ed optional=2E
+ *
+ * This is for messages that carry exactly one mandator=
y TLV, which is what the
+ * probe messages are=2E Any other TLV that is no=
t marked optional invalidates
+ * the message wherever it appears, as does =
a second TLV of wanted_type, so the
+ * whole sequence is walked even once =
the wanted TLV has been found=2E A message
+ * carrying several mandatory T=
LVs walks them with ctrl_msg_tlv_next() instead=2E
+ *
+ * On success value=
 covers exactly the found TLV's value bytes; as in
+ * ctrl_msg_tlv_next(),=
 a header claiming more bytes than payload holds is
+ * rejected rather tha=
n reported as found=2E payload is consumed as it is read=2E
+ *
+ * @param =
payload      buffer positioned at a TLV header
+ * @param wanted_type  the =
TLV type to look for
+ * @param value        set to a buffer covering the f=
ound TLV's value; it points
+ *                     into payload and owns n=
o storage
+ * @return true if the TLV was found, false if it is absent or p=
resent more
+ *         than once, if a TLV header or value is malformed or=
 truncated, or if
+ *         a TLV we do not understand is not marked opti=
onal=2E
+ */
+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t wante=
d_type, struct buffer *value);
+
 #endif /* ifndef CONTROL_MSG_H */
diff --=
git a/src/openvpn/probe=2Ec b/src/openvpn/probe=2Ec
new file mode 100644
in=
dex 0000000=2E=2E2497b07
--- /dev/null
+++ b/src/openvpn/probe=2Ec
@@ -0,0 =
+1,94 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
=
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
=
+ *             session authentication and key exchange,
+ *             pa=
cket encryption, packet authentication, and
+ *             packet compress=
ion=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+=
 *
+ *  This program is free software; you can redistribute it and/or modif=
y
+ *  it under the terms of the GNU General Public License version 2
+ *  =
as published by the Free Software Foundation=2E
+ *
+ *  This program is di=
stributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more d=
etails=2E
+ *
+ *  You should have received a copy of the GNU General Publi=
c License along
+ *  with this program; if not, see <https://www=2Egnu=2Eor=
g/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif=

+
+#include "syshead=2Eh"
+
+#include "probe=2Eh"
+#include "control_msg=
=2Eh"
+
+bool
+probe_request_write(struct buffer *buf, const struct probe_r=
equest *r)
+{
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REQ=
UEST, false, PROBE_REQUEST_LEN)
+           && buf_write_u64(buf, r->reques=
t_id) && buf_write_u64(buf, r->timestamp)
+           && buf_write_u32(buf,=
 r->flags);
+}
+
+bool
+probe_request_read(struct buffer *buf, struct probe=
_request *r)
+{
+    /* One bounds check covers the whole value: every fiel=
d read below then fits
+     * by construction, PROBE_REQUEST_LEN being the=
 sum of their sizes, so none
+     * of them needs its own error handling=
=2E Trailing bytes this version does
+     * not understand are simply left=
 unread=2E */
+    if (buf_len(buf) < PROBE_REQUEST_LEN)
+    {
+        re=
turn false;
+    }
+    r->request_id =3D buf_read_u64(buf, NULL);
+    r->=
timestamp =3D buf_read_u64(buf, NULL);
+    r->flags =3D buf_read_u32(buf, =
NULL);
+    return true;
+}
+
+bool
+probe_reply_write(struct buffer *buf, =
const struct probe_reply *r)
+{
+    return ctrl_msg_tlv_write_header(buf, =
TLV_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)
+           && buf_write_u64(=
buf, r->request_id) && buf_write_u16(buf, r->priority)
+           && buf_w=
rite_u16(buf, r->weight) && buf_write_u16(buf, r->max_latency_diff)
+      =
     && buf_write_u16(buf, r->connect_lifetime) && buf_write_u16(buf, r->fl=
ags);
+}
+
+bool
+probe_reply_read(struct buffer *buf, struct probe_reply *=
r)
+{
+    /* One bounds check for the whole value, as in probe_request_rea=
d()=2E */
+    if (buf_len(buf) < PROBE_REPLY_LEN)
+    {
+        return f=
alse;
+    }
+    r->request_id =3D buf_read_u64(buf, NULL);
+    r->priori=
ty =3D (uint16_t)buf_read_u16(buf);
+    r->weight =3D (uint16_t)buf_read_u=
16(buf);
+    r->max_latency_diff =3D (uint16_t)buf_read_u16(buf);
+    r->=
connect_lifetime =3D (uint16_t)buf_read_u16(buf);
+    r->flags =3D (uint16=
_t)buf_read_u16(buf);
+
+    /* The other addresses of the remote cannot be=
 both the same server and
+     * distinct ones=2E And LIFETIME_SHARED exte=
nds the connect_lifetime to those
+     * other addresses, which says nothi=
ng unless ADDRS_EQUAL has declared them
+     * the same server to begin wi=
th=2E */
+    if ((r->flags & PROBE_REPLY_FLAG_ADDRS_EQUAL) && (r->flags & =
PROBE_REPLY_FLAG_PROBE_MORE))
+    {
+        return false;
+    }
+    if =
((r->flags & PROBE_REPLY_FLAG_LIFETIME_SHARED) && !(r->flags & PROBE_REPLY_=
FLAG_ADDRS_EQUAL))
+    {
+        return false;
+    }
+    return true;
+=
}
diff --git a/src/openvpn/probe=2Eh b/src/openvpn/probe=2Eh
new file mode =
100644
index 0000000=2E=2E6001774
--- /dev/null
+++ b/src/openvpn/probe=2Eh=

@@ -0,0 +1,141 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP=
 networks
+ *             over a single TCP/UDP port, with support for SSL/=
TLS-based
+ *             session authentication and key exchange,
+ *     =
        packet encryption, packet authentication, and
+ *             packe=
t compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvp=
n=2Enet>
+ *
+ *  This program is free software; you can redistribute it an=
d/or modify
+ *  it under the terms of the GNU General Public License versi=
on 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This pro=
gram is distributed in the hope that it will be useful,
+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License =
for more details=2E
+ *
+ *  You should have received a copy of the GNU Gen=
eral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding and decoding =
of the server probe TLVs=2E
+ *
+ * A client probes a server by sending a P=
_CONTROL_V2 message whose payload
+ * carries a probe request TLV, and the =
server answers with a P_CONTROL_V2
+ * message carrying a probe reply TLV=
=2E The reply tells the client how the
+ * server wants to be ranked agains=
t the other remotes, and can also serve
+ * as the second packet of the thr=
ee-way handshake=2E
+ *
+ * The TLV framing and the TLV type space are shar=
ed with the other TLV-based
+ * control messages and live in control_msg=2E=
h; this file holds the two probe
+ * TLVs and what their fields mean=2E
+ *=
/
+
+#ifndef PROBE_H
+#define PROBE_H
+
+#include "buffer=2Eh"
+#include "c=
ontrol_msg=2Eh"
+
+/** probe request flags=2E The client is only probing: i=
t does not want to
+ * continue into a handshake, and the server may forget=
 it right away=2E */
+#define PROBE_REQUEST_FLAG_PROBE_ONLY 0x00000001
+
+/=
* probe reply flags */
+/** complete the handshake with P_CONTROL_WKC_V1 ra=
ther than P_CONTROL_V1 */
+#define PROBE_REPLY_FLAG_RESEND_WKC      0x0001
=
+/** the other addresses of this remote are the same server, no need to pro=
be them */
+#define PROBE_REPLY_FLAG_ADDRS_EQUAL     0x0002
+/** the connec=
t_lifetime holds against those other addresses too, so a reply
+ * from one=
 of them can skip the handshake with another=2E Only meaningful
+ * togethe=
r with ADDRS_EQUAL, which is what names those addresses=2E */
+#define PROB=
E_REPLY_FLAG_LIFETIME_SHARED 0x0004
+/** the other addresses of this remote=
 are distinct servers, so probe them too */
+#define PROBE_REPLY_FLAG_PROBE=
_MORE      0x0008
+
+/** probe request TLV, sent by a client to probe a ser=
ver */
+struct probe_request
+{
+    uint64_t request_id; /**< identifies t=
his probe, echoed in the reply */
+    /** The client clock as a UNIX times=
tamp in seconds=2E It is there for the
+     * server, which uses it to bou=
nd how old a request it will answer and so
+     * how long a captured one =
can be replayed=2E The reply does not echo it: a
+     * client times the r=
ound trip itself, by the request_id=2E */
+    uint64_t timestamp;
+    uin=
t32_t flags; /**< PROBE_REQUEST_FLAG_* */
+};
+
+/** probe reply TLV, a ser=
ver's answer to a probe request */
+struct probe_reply
+{
+    uint64_t req=
uest_id;       /**< echoes the request_id of the request */
+    uint16_t p=
riority;         /**< DNS SRV style priority, lower is preferred */
+    ui=
nt16_t weight;           /**< DNS SRV style weight */
+    uint16_t max_lat=
ency_diff; /**< candidate band in ms around the fastest server */
+    /** =
For how many seconds, counted from the moment the client sent its own
+    =
 * probe request, the server will still treat this exchange as the first
+ =
    * two packets of the handshake=2E Within that window the client may sen=
d the
+     * third packet straight away instead of starting a handshake of=
 its own=2E
+     * 0 means it cannot, so it has to begin a fresh one=2E */=

+    uint16_t connect_lifetime;
+    uint16_t flags; /**< PROBE_REPLY_FLAG=
_* */
+};
+
+/* Smallest on-wire value length (the TLV header not counted) =
of each TLV: the
+ * sizes of the fixed fields above, in wire order=2E A va=
lue may be longer, which
+ * is how the TLVs are extended; trailing bytes t=
hat are not understood are
+ * ignored on read=2E */
+
+/** request_id (u64=
), timestamp (u64), flags (u32) */
+#define PROBE_REQUEST_LEN ((uint16_t)(2=
 * sizeof(uint64_t) + sizeof(uint32_t)))
+
+/** request_id (u64), then prio=
rity, weight, max_latency_diff,
+ * connect_lifetime and flags (u16 each) *=
/
+#define PROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + 5 * sizeof(uint16=
_t)))
+
+/**
+ * Write a complete probe request TLV, header and value, to b=
uf=2E
+ *
+ * @return true on success, false if buf has insufficient space=
=2E
+ */
+bool probe_request_write(struct buffer *buf, const struct probe_r=
equest *r);
+
+/**
+ * Read a probe request TLV value from buf=2E
+ *
+ * b=
uf must cover exactly the TLV's value, as ctrl_msg_find_tlv() returns it=2E=

+ * Bytes beyond the fields understood here are ignored, so a longer value=
 from
+ * a future version still parses=2E Flag bits that are not known are=
 kept in
+ * flags rather than rejected, for the same reason=2E
+ *
+ * @re=
turn true on success, false if buf is shorter than the mandatory fields=2E
=
+ */
+bool probe_request_read(struct buffer *buf, struct probe_request *r);=

+
+/**
+ * Write a complete probe reply TLV, header and value, to buf=2E
+=
 *
+ * @return true on success, false if buf has insufficient space=2E
+ */=

+bool probe_reply_write(struct buffer *buf, const struct probe_reply *r);
=
+
+/**
+ * Read a probe reply TLV value from buf=2E The calling convention =
is that of
+ * probe_request_read()=2E
+ *
+ * The two flag combinations th=
e protocol rules out are rejected here, since
+ * neither can be acted on: =
a reply must not call the other addresses of the
+ * remote both the same s=
erver and distinct ones, and it must not extend the
+ * connect_lifetime to=
 those addresses without first calling them the same
+ * server=2E
+ *
+ * =
@return true on success, false if buf is shorter than the mandatory fields
=
+ *         or the flags contradict each other=2E
+ */
+bool probe_reply_re=
ad(struct buffer *buf, struct probe_reply *r);
+
+#endif /* ifndef PROBE_H =
*/
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ca5958f=2E=
=2E7793c0a 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3=
745,21 +3745,32 @@
 
 /**
  * Does a very coarse check on the received opco=
de=2E It only checks if the
- * opcode is an allowed op code for the peer t=
o send at all, not if this
- * opcode is valid for the current state=2E
+ *=
 opcode is one the peer may send on the reliable control channel at all,
+ =
* not if this opcode is valid for the current state=2E
  */
 static bool
 t=
ls_pre_decrypt_verify_opcode(int op, bool server, const struct link_socket_=
actual *from)
 {
-    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    i=
f (!opcode_is_reliable_control(op))
     {
         if (op =3D=3D P_CONTROL=
_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
        =
 {
             msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
 =
        }
         struct gc_arena gc =3D gc_new();
-        msg(D_TLS_ERRO=
RS, "TLS Error: unknown opcode received from %s op=3D%d",
-            prin=
t_link_socket_actual(from, &gc), op);
+        if (op =3D=3D P_CONTROL_V2 |=
| op =3D=3D P_CONTROL_WKC_V2)
+        {
+            /* a defined opcode, =
just not one this path can parse */
+            msg(D_TLS_ERRORS,
+       =
         "TLS Error: %s received from %s, which is not part of "
+         =
       "the reliable control channel",
+                packet_opcode_name(=
op), print_link_socket_actual(from, &gc));
+        }
+        else
+      =
  {
+            msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from=
 %s op=3D%d",
+                print_link_socket_actual(from, &gc), op);
+ =
       }
         gc_free(&gc);
         return false;
     }
diff --git a/=
src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index dad58c3=2E=2Eb0377f=
3 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -17=
4,7 +174,8 @@
                    bool prepend_ack)
 {
     ASSERT(ks->key_=
id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
-    ASSERT(opcode >=3D 0 && o=
pcode <=3D P_LAST_OPCODE);
+    /* this writes the message id and ACK array=
, which only these opcodes have */
+    ASSERT(opcode_is_reliable_control(o=
pcode));
     uint8_t header =3D (uint8_t)(ks->key_id | (opcode << P_OPCODE=
_SHIFT));
 
     /* Workaround for Softether servers=2E Softether has a bug=
 that it only
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2E=
h
index 218c6bb=2E=2E3b45492 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src=
/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,50 @@
  * like P_CONTROL_HARD_RESET_CLIE=
NT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* define the range of legal opcod=
es
- * Since we do no longer support key-method 1 we consider
- * the v1 op=
 codes invalid */
-#define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  11
+/* =
Control channel packet carrying a TLV payload, e=2Eg=2E a server probe=2E F=
ramed
+ * like P_CONTROL_V1 but without the fields of the reliability layer=
: a session
+ * id and then the TLVs, with no message id and no ACK array=
=2E It is wrapped by
+ * tls-auth or tls-crypt like any other control chann=
el packet, and with
+ * neither configured it travels unauthenticated, as t=
hey do=2E */
+#define P_CONTROL_V2 12
+
+/* Variant of P_CONTROL_V2 with th=
e wrapped client key appended,
+ * like P_CONTROL_WKC_V1 is to P_CONTROL_V1=
 */
+#define P_CONTROL_WKC_V2 13
+
+/**
+ * Is a packet with opcode op carr=
ied by the reliable control channel?
+ *
+ * These opcodes are followed by =
an ACK array and a control message id, which
+ * is what the reliable path =
reads once it is past the session id=2E An opcode
+ * that is not one of th=
em has something else there: P_CONTROL_V2 has its TLVs=2E
+ * Handing such =
a packet to that path would read the first bytes of that
+ * payload as an =
ACK count and a message id, and ACK or queue whatever it made
+ * of them=
=2E
+ *
+ * The opcodes are listed rather than bounded by a range, so that =
defining one
+ * does not silently add it to the set=2E Key method 1 is no =
longer supported, so
+ * its two reset opcodes are not here, and the data c=
hannel opcodes are handled
+ * before this is reached=2E
+ */
+static inlin=
e bool
+opcode_is_reliable_control(int op)
+{
+    switch (op)
+    {
+    =
    case P_CONTROL_SOFT_RESET_V1:
+        case P_CONTROL_V1:
+        case=
 P_ACK_V1:
+        case P_CONTROL_HARD_RESET_CLIENT_V2:
+        case P_CO=
NTROL_HARD_RESET_SERVER_V2:
+        case P_CONTROL_HARD_RESET_CLIENT_V3:
+=
        case P_CONTROL_WKC_V1:
+            return true;
+
+        default=
:
+            return false;
+    }
+}
 
 /*
  * Define number of buffers f=
or send and receive in the reliability layer=2E
@@ -257,6 +296,12 @@
      =
   case P_CONTROL_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+      =
  case P_CONTROL_V2:
+            return "P_CONTROL_V2";
+
+        case P_=
CONTROL_WKC_V2:
+            return "P_CONTROL_WKC_V2";
+
         case P_A=
CK_V1:
             return "P_ACK_V1";
 
diff --git a/tests/unit_tests/open=
vpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index e3404754=
=2E=2Eb06ae5e 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tes=
ts/unit_tests/openvpn/Makefile=2Eam
@@ -166,6 +166,7 @@
 pkt_testdriver_LDF=
LAGS =3D @TEST_LDFLAGS@
 pkt_testdriver_SOURCES =3D test_pkt=2Ec \
 	test_c=
ontrol_msg=2Ec test_control_msg=2Eh \
+	test_probe=2Ec test_probe=2Eh \
 	m=
ock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
 	test_common=2Eh \
 	$(to=
p_srcdir)/src/compat/compat-strlcpy=2Ec \
@@ -181,6 +182,7 @@
 	$(top_srcdi=
r)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/packet_id=2Ec \
 	$(=
top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/openvpn/probe=2E=
c \
 	$(top_srcdir)/src/openvpn/reliable=2Ec \
 	$(top_srcdir)/src/openvpn/=
run_command=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec \
diff --git a=
/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=
=2Ec
index f34bd41=2E=2E5609c67 100644
--- a/tests/unit_tests/openvpn/test_=
pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -45,6 +45,7 @@
 #inc=
lude "reliable=2Eh"
 #include "siphash=2Eh"
 #include "test_control_msg=2Eh=
"
+#include "test_probe=2Eh"
 
 int
 parse_line(const char *line, char **p,=
 const int n, const char *file, const int line_num,
@@ -841,7 +842,21 @@
  =
       cmocka_unit_test(test_tlv_next_walks_payload),
         cmocka_unit_=
test(test_tlv_next_value_truncated),
         cmocka_unit_test(test_tlv_hea=
der_truncated),
-        cmocka_unit_test(test_tlv_write_no_room)
+        =
cmocka_unit_test(test_tlv_write_no_room),
+        cmocka_unit_test(test_pr=
obe_request_roundtrip),
+        cmocka_unit_test(test_probe_request_wire_f=
ormat),
+        cmocka_unit_test(test_probe_reply_roundtrip),
+        cmo=
cka_unit_test(test_probe_reply_wire_format),
+        cmocka_unit_test(test=
_probe_request_forward_compat),
+        cmocka_unit_test(test_probe_reques=
t_too_short),
+        cmocka_unit_test(test_probe_reply_too_short),
+     =
   cmocka_unit_test(test_probe_reply_flags_contradict),
+        cmocka_uni=
t_test(test_find_tlv_value_truncated),
+        cmocka_unit_test(test_find_=
tlv_trailing_bytes),
+        cmocka_unit_test(test_find_tlv_skips_optional=
_after_wanted),
+        cmocka_unit_test(test_find_tlv_rejects_unknown_man=
datory),
+        cmocka_unit_test(test_find_tlv_rejects_duplicate),
+     =
   cmocka_unit_test(test_find_tlv_empty_payload)
     };
 
     return cmoc=
ka_run_group_tests_name("pkt tests", tests, NULL, NULL);
diff --git a/tests=
/unit_tests/openvpn/test_probe=2Ec b/tests/unit_tests/openvpn/test_probe=2E=
c
new file mode 100644
index 0000000=2E=2E967252c
--- /dev/null
+++ b/tests=
/unit_tests/openvpn/test_probe=2Ec
@@ -0,0 +1,425 @@
+/*
+ *  OpenVPN -- An=
 application to securely tunnel IP networks
+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based
+ *             session authent=
ication and key exchange,
+ *             packet encryption, packet authent=
ication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2=
002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free so=
ftware; you can redistribute it and/or modify
+ *  it under the terms of th=
e GNU General Public License version 2
+ *  as published by the Free Softwa=
re Foundation=2E
+ *
+ *  This program is distributed in the hope that it w=
ill be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e
+ *  GNU General Public License for more details=2E
+ *
+ *  You should h=
ave received a copy of the GNU General Public License along
+ *  with this =
program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef =
HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#=
include <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#includ=
e <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include "probe=2Eh"
+#includ=
e "test_common=2Eh"
+#include "test_probe=2Eh"
+
+/* Write a probe request =
TLV and read it back; the fields must survive the
+ * round trip and the wh=
ole buffer must be consumed=2E */
+void
+test_probe_request_roundtrip(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    const struct probe_request in =3D {
+   =
     =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+        =2Etimestamp =3D 0x0=
123456789abcdefULL,
+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,
+ =
   };
+    assert_true(probe_request_write(&buf, &in));
+    assert_int_equ=
al(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUEST_LEN);
+
+    struct =
ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &h=
dr));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);
+    asser=
t_false(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, PROBE_REQUE=
ST_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&bu=
f, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), PR=
OBE_REQUEST_LEN);
+
+    struct probe_request out =3D { 0 };
+    assert_tr=
ue(probe_request_read(&value, &out));
+    assert_true(in=2Erequest_id =3D=
=3D out=2Erequest_id);
+    assert_true(in=2Etimestamp =3D=3D out=2Etimesta=
mp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    /* the scan consu=
med header and value alike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    =
gc_free(&gc);
+}
+
+/* The probe request wire format is locked to the field=
 order of the spec
+ * (request_id, timestamp, flags), big-endian=2E */
+vo=
id
+test_probe_request_wire_format(void **state)
+{
+    struct gc_arena gc=
 =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    co=
nst struct probe_request in =3D {
+        =2Erequest_id =3D 0x112233445566=
7788ULL,
+        =2Etimestamp =3D 0x0102030405060708ULL,
+        =2Eflags=
 =3D 0,
+    };
+    assert_true(probe_request_write(&buf, &in));
+
+    /*=
 clang-format off */
+    const uint8_t expected[] =3D {
+        0x00, 0x0=
2,                                     /* TLV type 2, not optional */
+    =
    0x00, 0x14,                                     /* TLV value length =3D=
 20 */
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_=
id */
+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, /* timestamp=
 */
+        0x00, 0x00, 0x00, 0x00,                         /* flags */
+ =
   };
+    /* clang-format on */
+    assert_int_equal(BLEN(&buf), sizeof(e=
xpected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expected))=
;
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and read it back=2E=
 */
+void
+test_probe_reply_roundtrip(void **state)
+{
+    struct gc_arena=
 gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+   =
 const struct probe_reply in =3D {
+        =2Erequest_id =3D 0x11223344556=
67788ULL,
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,
+       =
 =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 30,
+        =
=2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert_true(probe_=
reply_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEA=
DER_LEN + PROBE_REPLY_LEN);
+
+    struct ctrl_msg_tlv_header hdr;
+    ass=
ert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+    assert_int_equal(hdr=
=2Etype, TLV_TYPE_PROBE_REPLY);
+    assert_false(hdr=2Eoptional);
+    ass=
ert_int_equal(hdr=2Evalue_len, PROBE_REPLY_LEN);
+
+    struct buffer value=
;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REPLY, &value));
=
+
+    struct probe_reply out =3D { 0 };
+    assert_true(probe_reply_read(=
&value, &out));
+    assert_true(in=2Erequest_id =3D=3D out=2Erequest_id);
=
+    assert_int_equal(in=2Epriority, out=2Epriority);
+    assert_int_equal=
(in=2Eweight, out=2Eweight);
+    assert_int_equal(in=2Emax_latency_diff, o=
ut=2Emax_latency_diff);
+    assert_int_equal(in=2Econnect_lifetime, out=2E=
connect_lifetime);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    ass=
ert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe reply=
 wire format is locked to the field order of the spec
+ * (request_id, prio=
rity, weight, max_latency_diff, connect_lifetime, flags),
+ * big-endian=2E=
 */
+void
+test_probe_reply_wire_format(void **state)
+{
+    struct gc_are=
na gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+ =
   const struct probe_reply in =3D {
+        =2Erequest_id =3D 0x112233445=
5667788ULL,
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,
+     =
   =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 30,
+      =
  =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert_true(prob=
e_reply_write(&buf, &in));
+
+    /* clang-format off */
+    const uint8_t=
 expected[] =3D {
+        0x00, 0x03,                                     =
/* TLV type 3, not optional */
+        0x00, 0x12,                        =
             /* TLV value length =3D 18 */
+        0x11, 0x22, 0x33, 0x44,=
 0x55, 0x66, 0x77, 0x88, /* request_id */
+        0x00, 0x0a,             =
                        /* priority =3D 10 */
+        0x00, 0x64,         =
                            /* weight =3D 100 */
+        0x00, 0x19,      =
                               /* max_latency_diff =3D 25 */
+        0x00,=
 0x1e,                                     /* connect_lifetime =3D 30 */
+ =
       0x00, 0x01,                                     /* flags =3D RESEND_=
WKC */
+    };
+    /* clang-format on */
+    assert_int_equal(BLEN(&buf),=
 sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(e=
xpected));
+
+    gc_free(&gc);
+}
+
+/* A TLV with a longer-than-known val=
ue must still parse: the known fields are
+ * read and the trailing bytes a=
re skipped=2E Flag bits we do not know are kept
+ * rather than rejected, f=
or the same forward compatibility=2E */
+void
+test_probe_request_forward_c=
ompat(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_t extended_len =3D=
 PROBE_REQUEST_LEN + 4;
+    assert_true(ctrl_msg_tlv_write_header(&buf, TL=
V_TYPE_PROBE_REQUEST, false, extended_len));
+    assert_true(buf_write_u64=
(&buf, 7));             /* request_id */
+    assert_true(buf_write_u64(&bu=
f, 0xdeadbeefULL)); /* timestamp */
+    assert_true(buf_write_u32(&buf, 0x=
80000000));    /* flags, unknown bit set */
+    assert_true(buf_write_u32(=
&buf, 0x11223344));    /* unknown trailing field */
+
+    struct buffer va=
lue;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &valu=
e));
+    assert_int_equal(BLEN(&value), extended_len);
+
+    struct probe=
_request out =3D { 0 };
+    assert_true(probe_request_read(&value, &out));=

+    assert_true(out=2Erequest_id =3D=3D 7);
+    assert_true(out=2Etimest=
amp =3D=3D 0xdeadbeefULL);
+    assert_true(out=2Eflags =3D=3D 0x80000000);=

+    /* the unknown trailing field must have been consumed from the payloa=
d */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A =
value shorter than the mandatory fields must be rejected, even when it
+ * =
holds enough bytes for some of the individual fields to read successfully=
=2E */
+void
+test_probe_request_too_short(void **state)
+{
+    struct gc_=
arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+=

+    /* 8 of the 20 mandatory value bytes: enough for the request_id alone=
 */
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL));
+
+    struct pro=
be_request out =3D { 0 };
+    assert_false(probe_request_read(&buf, &out))=
;
+
+    gc_free(&gc);
+}
+
+/* The same for the reply, one u16 short of it=
s 18 mandatory bytes=2E */
+void
+test_probe_reply_too_short(void **state)
=
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_b=
uf_gc(128, &gc);
+
+    assert_true(buf_write_u64(&buf, 1));
+    for (int =
i =3D 0; i < 4; i++)
+    {
+        assert_true(buf_write_u16(&buf, 0));
+=
    }
+
+    struct probe_reply out =3D { 0 };
+    assert_false(probe_repl=
y_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* The flag combinations th=
e protocol rules out must be rejected: the other
+ * addresses of a remote =
cannot be both the same server and distinct ones, and
+ * a shared connect_=
lifetime needs them to have been called equal=2E */
+void
+test_probe_reply=
_flags_contradict(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   const uint16_t bad[] =3D {
+        PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE=
_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_LIFETIME_SHARED,
+       =
 PROBE_REPLY_FLAG_LIFETIME_SHARED | PROBE_REPLY_FLAG_PROBE_MORE,
+    };
+ =
   const uint16_t good[] =3D {
+        0,
+        PROBE_REPLY_FLAG_ADDRS_=
EQUAL,
+        PROBE_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_ADDR=
S_EQUAL | PROBE_REPLY_FLAG_LIFETIME_SHARED,
+    };
+
+    for (size_t i =
=3D 0; i < SIZE(bad) + SIZE(good); i++)
+    {
+        const bool expect_o=
k =3D i >=3D SIZE(bad);
+        const uint16_t flags =3D expect_ok ? good[=
i - SIZE(bad)] : bad[i];
+
+        struct buffer buf =3D alloc_buf_gc(128,=
 &gc);
+        const struct probe_reply in =3D { =2Erequest_id =3D 1, =2Ef=
lags =3D flags };
+        assert_true(probe_reply_write(&buf, &in));
+
+  =
      struct buffer value;
+        assert_true(ctrl_msg_find_tlv(&buf, TLV=
_TYPE_PROBE_REPLY, &value));
+
+        struct probe_reply out =3D { 0 };
+=
        assert_int_equal(probe_reply_read(&value, &out), expect_ok);
+    }=

+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than =
the payload holds must be
+ * rejected by the scan rather than reported as =
found -- for the TLV being
+ * looked for as much as for one that would mer=
ely be skipped=2E */
+void
+test_find_tlv_value_truncated(void **state)
+{
=
+    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+    /* t=
he wanted TLV declares 20 value bytes, only 8 are present */
+    struct bu=
ffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_he=
ader(&buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN));
+    assert_=
true(buf_write_u64(&buf, 0xdeadbeefULL));
+    assert_false(ctrl_msg_find_t=
lv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    /* same defect on a TLV t=
hat would be skipped: the scan must not walk past
+     * the end of the pa=
yload looking for the next header */
+    struct buffer buf2 =3D alloc_buf_=
gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf2, 0x7ff, fals=
e, 64));
+    assert_true(buf_write_u32(&buf2, 0));
+    assert_false(ctrl_=
msg_find_tlv(&buf2, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
=
+}
+
+/* Bytes left over after the last TLV that are too few for a header m=
ake the
+ * message malformed, even when the wanted TLV was already found=
=2E */
+void
+test_find_tlv_trailing_bytes(void **state)
+{
+    struct gc_=
arena gc =3D gc_new();
+    struct buffer value;
+
+    /* 1 to 3 bytes: le=
ss than a 4-byte TLV header */
+    for (int trailing =3D 1; trailing < CTR=
L_MSG_TLV_HEADER_LEN; trailing++)
+    {
+        struct buffer buf =3D all=
oc_buf_gc(128, &gc);
+        const struct probe_request in =3D { =2Ereques=
t_id =3D 1, =2Etimestamp =3D 1 };
+        assert_true(probe_request_write(=
&buf, &in));
+        for (int i =3D 0; i < trailing; i++)
+        {
+    =
        assert_true(buf_write_u8(&buf, 0));
+        }
+        assert_fals=
e(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    }
+
+    g=
c_free(&gc);
+}
+
+/* An unknown TLV marked optional after the wanted one i=
s skipped, and the
+ * wanted value is still the one returned=2E */
+void
+=
test_find_tlv_skips_optional_after_wanted(void **state)
+{
+    struct gc_a=
rena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+ =
   struct buffer value;
+
+    const struct probe_request in =3D { =2Ereque=
st_id =3D 1, =2Etimestamp =3D 7 };
+    assert_true(probe_request_write(&bu=
f, &in));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4))=
;
+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_true(ctrl_msg_fin=
d_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&v=
alue), PROBE_REQUEST_LEN);
+    struct probe_request out =3D { 0 };
+    as=
sert_true(probe_request_read(&value, &out));
+    assert_true(out=2Etimesta=
mp =3D=3D 7);
+
+    gc_free(&gc);
+}
+
+/* A TLV we do not know that is no=
t marked optional carries something its
+ * sender requires us to act on, s=
o the scan rejects the message whether that
+ * TLV comes before or after t=
he wanted one=2E */
+void
+test_find_tlv_rejects_unknown_mandatory(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+ =
   const struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =
=3D 7 };
+
+    struct buffer before =3D alloc_buf_gc(128, &gc);
+    asser=
t_true(ctrl_msg_tlv_write_header(&before, 0x7ff, false, 4));
+    assert_tr=
ue(buf_write_u32(&before, 0xcafef00d));
+    assert_true(probe_request_writ=
e(&before, &in));
+
+    struct buffer after =3D alloc_buf_gc(128, &gc);
+ =
   assert_true(probe_request_write(&after, &in));
+    assert_true(ctrl_msg=
_tlv_write_header(&after, 0x7ff, false, 4));
+    assert_true(buf_write_u32=
(&after, 0xcafef00d));
+
+    assert_false(ctrl_msg_find_tlv(&before, TLV_T=
YPE_PROBE_REQUEST, &value));
+    assert_false(ctrl_msg_find_tlv(&after, TL=
V_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* The wanted TL=
V may occur only once: a second one rejects the message=2E Repeats
+ * of a=
n unknown TLV marked optional are skipped like any other=2E */
+void
+test_=
find_tlv_rejects_duplicate(void **state)
+{
+    struct gc_arena gc =3D gc_=
new();
+    struct buffer value;
+    const struct probe_request in =3D { =
=2Erequest_id =3D 1 };
+
+    struct buffer buf =3D alloc_buf_gc(128, &gc);=

+    assert_true(probe_request_write(&buf, &in));
+    assert_true(probe_r=
equest_write(&buf, &in));
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYP=
E_PROBE_REQUEST, &value));
+
+    buf =3D alloc_buf_gc(128, &gc);
+    for =
(int i =3D 0; i < 2; i++)
+    {
+        assert_true(ctrl_msg_tlv_write_he=
ader(&buf, 0x7ff, true, 4));
+        assert_true(buf_write_u32(&buf, 0));
=
+    }
+    assert_true(probe_request_write(&buf, &in));
+    assert_true(c=
trl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc=
);
+}
+
+/* An empty payload holds no TLV=2E */
+void
+test_find_tlv_empty_=
payload(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer buf =3D alloc_buf_gc(16, &gc);
+    struct buffer value;
+
+    asse=
rt_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    g=
c_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_probe=2Eh b/test=
s/unit_tests/openvpn/test_probe=2Eh
new file mode 100644
index 0000000=2E=
=2E9c4137d
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_probe=2Eh
@@ -=
0,0 +1,54 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks
+ *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed
+ *             session authentication and key exchange,
+ *           =
  packet encryption, packet authentication, and
+ *             packet comp=
ression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Ene=
t>
+ *
+ *  This program is free software; you can redistribute it and/or m=
odify
+ *  it under the terms of the GNU General Public License version 2
+=
 *  as published by the Free Software Foundation=2E
+ *
+ *  This program i=
s distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS =
FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for mo=
re details=2E
+ *
+ *  You should have received a copy of the GNU General P=
ublic License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_PROBE_H
+#define TEST_PROBE_H
+
+=
void test_probe_request_roundtrip(void **state);
+
+void test_probe_request=
_wire_format(void **state);
+
+void test_probe_reply_roundtrip(void **state=
);
+
+void test_probe_reply_wire_format(void **state);
+
+void test_probe_r=
equest_forward_compat(void **state);
+
+void test_probe_request_too_short(v=
oid **state);
+
+void test_probe_reply_too_short(void **state);
+
+void tes=
t_probe_reply_flags_contradict(void **state);
+
+void test_find_tlv_value_t=
runcated(void **state);
+
+void test_find_tlv_trailing_bytes(void **state);=

+
+void test_find_tlv_skips_optional_after_wanted(void **state);
+
+void t=
est_find_tlv_rejects_unknown_mandatory(void **state);
+
+void test_find_tlv=
_rejects_duplicate(void **state);
+
+void test_find_tlv_empty_payload(void =
**state);
+
+#endif

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit=
-PatchSet: 29
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf Lici <ralf@mandelb=
it=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--5hvcIFOrykU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">control_msg: Add P_CONTROL_V2 and =
the probe request and reply TLVs<br><br>A client probes a server before con=
necting by sending a P_CONTROL_V2<br>message carrying a probe request TLV, =
and the server answers with a<br>P_CONTROL_V2 carrying a probe reply=2E The=
 reply tells the client how the<br>server wants to be ranked against the ot=
her remotes, and can also serve<br>as the second packet of the three-way ha=
ndshake=2E<br><br>Add the two opcodes and the two TLV codecs the probe need=
s=2E P_CONTROL_V2<br>is framed like P_CONTROL_V1 but without the fields of =
the reliability<br>layer: a session id and then the TLVs, with no control m=
essage id and no<br>ACK array=2E P_CONTROL_WKC_V2 is the same with the wrap=
ped client key<br>appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1=2E<br><b=
r>The TLVs use the shared TLV codec, control_msg=2Ec/h, and their two types=
<br>join the others there=2E The codec gains ctrl_msg_find_tlv(), which sca=
ns<br>a payload for the one mandatory TLV of a message=2E The scan is stric=
t: a<br>truncated TLV header or value, a second TLV of the wanted type, or =
an<br>unknown TLV not marked optional rejects the whole message=2E<br><br>B=
oth readers accept a value longer than the fields they know and ignore<br>t=
he excess, which is how the TLVs are meant to be extended=2E The probe<br>r=
eply reader does reject the two flag combinations the protocol rules<br>out=
, as neither can be acted on: the other addresses of a remote cannot<br>be =
both the same server and distinct ones, and the connect_lifetime<br>cannot =
be extended to those addresses without first calling them the<br>same serve=
r=2E<br><br>The reliable control path no longer decides what it handles fro=
m an<br>opcode range=2E P_FIRST_OPCODE and P_LAST_OPCODE give way to<br>opc=
ode_is_reliable_control(), which lists the opcodes that carry a<br>message =
id and an ACK array, and tls_pre_decrypt_verify_opcode() and<br>write_contr=
ol_auth() test that instead=2E Defining an opcode therefore no<br>longer jo=
ins it to that set, so the two opcodes added here need no<br>carve-out from=
 a range=2E<br><br>No opcode changes hands: the old range covered exactly t=
he seven listed,<br>plus the two data channel opcodes, which are handled be=
fore the check is<br>reached=2E<br><br>The probe is not sent or answered ye=
t; that follows=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be369437388=
268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741<br>Message-Id: &lt;20261119130414=2E20274=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41678=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M =
src/openvpn/Makefile=2Eam<br>M src/openvpn/control_msg=2Ec<br>M src/openvpn=
/control_msg=2Eh<br>A src/openvpn/probe=2Ec<br>A src/openvpn/probe=2Eh<br>M=
 src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=
=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/open=
vpn/test_pkt=2Ec<br>A tests/unit_tests/openvpn/test_probe=2Ec<br>A tests/un=
it_tests/openvpn/test_probe=2Eh<br>13 files changed, 860 insertions(+), 12 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2E=
txt</span><br><span>index 50b2d68=2E=2Ec6dcf65 100644</span><br><span>--- a=
/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@=
 -565,6 +565,8 @@</span><br><span>     src/openvpn/plugin=2Eh</span><br><sp=
an>     src/openvpn/pool=2Ec</span><br><span>     src/openvpn/pool=2Eh</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/probe=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pr=
obe=2Eh</span><br><span>     src/openvpn/proto=2Ec</span><br><span>     src=
/openvpn/proto=2Eh</span><br><span>     src/openvpn/proxy=2Ec</span><br><sp=
an>@@ -899,7 +901,9 @@</span><br><span>     target_sources(test_pkt PRIVATE=
</span><br><span>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</s=
pan><br><span>         tests/unit_tests/openvpn/test_control_msg=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/o=
penvpn/test_probe=2Ec</span><br><span>         src/openvpn/control_msg=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
probe=2Ec</span><br><span>         src/openvpn/argv=2Ec</span><br><span>   =
      src/openvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_ep=
och=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvp=
n/Makefile=2Eam</span><br><span>index be1044d=2E=2E4c8edea 100644</span><br=
><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Ma=
kefile=2Eam</span><br><span>@@ -121,6 +121,7 @@</span><br><span> 	ping=2Ec =
ping=2Eh \</span><br><span> 	plugin=2Ec plugin=2Eh \</span><br><span> 	pool=
=2Ec pool=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	pro=
be=2Ec probe=2Eh \</span><br><span> 	proto=2Ec proto=2Eh \</span><br><span>=
 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span>d=
iff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span=
><br><span>index e14355c=2E=2Ea77413f 100644</span><br><span>--- a/src/open=
vpn/control_msg=2Ec</span><br><span>+++ b/src/openvpn/control_msg=2Ec</span=
><br><span>@@ -91,3 +91,32 @@</span><br><span>     buf_set_read(value, v, h=
dr-&gt;value_len);</span><br><span>     return true;</span><br><span> }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wante=
d_type, struct buffer *value)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 found =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  while (BLEN(payload) &gt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct buffer v;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_next(payload, &amp;hdr, &am=
p;v))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Etype =3D=
=3D wanted_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
return false; /* the TLV may occur only once */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            *value =3D v;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            found =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else if (!hdr=2Eoptional)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return false; /* a mandatory TLV =
we do not understand, wherever it sits */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return found;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span>diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/contro=
l_msg=2Eh</span><br><span>index 92572cb=2E=2E8ad5530 100644</span><br><span=
>--- a/src/openvpn/control_msg=2Eh</span><br><span>+++ b/src/openvpn/contro=
l_msg=2Eh</span><br><span>@@ -41,6 +41,8 @@</span><br><span> </span><br><sp=
an> /* TLV types */</span><br><span> #define TLV_TYPE_EARLY_NEG_FLAGS 0x000=
1 /* early negotiation, in the reset packets */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REQUEST   0x0002 /* a cl=
ient probing a server, in P_CONTROL_V2 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REPLY     0x0003 /* the server=
&#39;s answer, in P_CONTROL_V2 */</span><br><span> </span><br><span> /* A T=
LV header is a 16-bit type/optional field plus a 16-bit length */</span><br=
><span> #define CTRL_MSG_TLV_HEADER_LEN 4</span><br><span>@@ -105,4 +107,28=
 @@</span><br><span>  */</span><br><span> bool ctrl_msg_tlv_next(struct buf=
fer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan payload for the TLV=
 of type wanted_type, skipping any other TLV type</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * that is marked optional=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * This is for messages that carry exactly one manda=
tory TLV, which is what the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * probe messages are=2E Any other TLV that is not marked optional =
invalidates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the m=
essage wherever it appears, as does a second TLV of wanted_type, so the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whole sequence is wa=
lked even once the wanted TLV has been found=2E A message</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * carrying several mandatory TLVs wa=
lks them with ctrl_msg_tlv_next() instead=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * On success value covers exactly the found TLV&#39;s value bytes;=
 as in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ctrl_msg_t=
lv_next(), a header claiming more bytes than payload holds is</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * rejected rather than reported =
as found=2E payload is consumed as it is read=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param payload      buffer positioned at a TLV header</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param wanted_type  the=
 TLV type to look for</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param value        set to a buffer covering the found TLV&#39;s value=
; it points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
               into payload and owns no storage</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @return true if the TLV was found, false if =
it is absent or present more</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *         than once, if a TLV header or value is malformed or tru=
ncated, or if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
     a TLV we do not understand is not marked optional=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool ctrl_msg_find_tlv(struct buffer *payload, uint16=
_t wanted_type, struct buffer *value);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> #endif /* ifndef CONTROL_MSG_H */</spa=
n><br><span>diff --git a/src/openvpn/probe=2Ec b/src/openvpn/probe=2Ec</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E2497b07=
</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/probe=2Ec<=
/span><br><span>@@ -0,0 +1,94 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
OpenVPN -- An application to securely tunnel IP networks</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP p=
ort, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             session authentication and key exchange,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet e=
ncryption, packet authentication, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             packet compression=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;probe=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prob=
e_request_write(struct buffer *buf, const struct probe_request *r)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, TLV_=
TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u64(buf, r-&gt;re=
quest_id) &amp;&amp; buf_write_u64(buf, r-&gt;timestamp)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(bu=
f, r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+probe_request_read(struct buffer *buf, struct probe_req=
uest *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds check cover=
s the whole value: every field read below then fits</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * by construction, PROBE_REQUEST_LEN=
 being the sum of their sizes, so none</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * of them needs its own error handling=2E Trailing =
bytes this version does</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * not understand are simply left unread=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; PROBE_REQUEST_=
LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D buf_read_u64(buf=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;t=
imestamp =3D buf_read_u64(buf, NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_reply_=
write(struct buffer *buf, const struct probe_reply *r)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_R=
EPLY, false, PROBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           &amp;&amp; buf_write_u64(buf, r-&gt;request_id) &amp;&=
amp; buf_write_u16(buf, r-&gt;priority)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;weight) =
&amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, =
r-&gt;connect_lifetime) &amp;&amp; buf_write_u16(buf, r-&gt;flags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prob=
e_reply_read(struct buffer *buf, struct probe_reply *r)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* One bounds check for the whole value, as in probe_=
request_read()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (buf_len(buf) &lt; PROBE_REPLY_LEN)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  r-&gt;request_id =3D buf_read_u64(buf, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_t)buf_read_u16(b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;weigh=
t =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)buf_read_u16(buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;connect_li=
fetime =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    r-&gt;flags =3D (uint16_t)buf_read_u16(buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* The other addresses of the remote cann=
ot be both the same server and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * distinct ones=2E And LIFETIME_SHARED extends the connect_=
lifetime to those</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * other addresses, which says nothing unless ADDRS_EQUAL has declared th=
em</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the same s=
erver to begin with=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if ((r-&gt;flags &amp; PROBE_REPLY_FLAG_ADDRS_EQUAL) &amp;&amp; (=
r-&gt;flags &amp; PROBE_REPLY_FLAG_PROBE_MORE))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if ((r-&gt;flags &amp; PROBE_REPLY_FLAG_LIFETIME_SHARED) &amp;&amp; !=
(r-&gt;flags &amp; PROBE_REPLY_FLAG_ADDRS_EQUAL))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span>diff --git a/src/openvpn/probe=2Eh b/src/openvpn/probe=
=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E6001774</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
probe=2Eh</span><br><span>@@ -0,0 +1,141 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             session authentication and key ex=
change,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sa=
les@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progra=
m is free software; you can redistribute it and/or modify</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gen=
eral Public License version 2</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that i=
t will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  GNU General Public License for more details=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Encoding and decoding of the server probe TLVs=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * A client probes a server by sending a P_CON=
TROL_V2 message whose payload</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * carries a probe request TLV, and the server answers with a P_C=
ONTROL_V2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * message=
 carrying a probe reply TLV=2E The reply tells the client how the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * server wants to be ranked =
against the other remotes, and can also serve</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * as the second packet of the three-way handshak=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * The TLV framing and the TLV t=
ype space are shared with the other TLV-based</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * control messages and live in control_msg=2Eh; =
this file holds the two probe</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * TLVs and what their fields mean=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 PROBE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PRO=
BE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control=
_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** probe request flags=
=2E The client is only probing: it does not want to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * continue into a handshake, and the ser=
ver may forget it right away=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define PROBE_REQUEST_FLAG_PROBE_ONLY 0x00000001</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* probe reply flags */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/** complete the handshake with P_CONTROL_WKC_=
V1 rather than P_CONTROL_V1 */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define PROBE_REPLY_FLAG_RESEND_WKC      0x0001</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/** the other addresses of this remo=
te are the same server, no need to probe them */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_ADDRS_EQUAL     0x000=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** the connect_li=
fetime holds against those other addresses too, so a reply</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * from one of them can skip the han=
dshake with another=2E Only meaningful</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * together with ADDRS_EQUAL, which is what names those =
addresses=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine PROBE_REPLY_FLAG_LIFETIME_SHARED 0x0004</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/** the other addresses of this remote are distinct=
 servers, so probe them too */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define PROBE_REPLY_FLAG_PROBE_MORE      0x0008</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** probe request TLV, sent by a client to probe a serv=
er */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct probe_r=
equest</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t request_id; /**&lt=
; identifies this probe, echoed in the reply */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /** The client clock as a UNIX timestamp in=
 seconds=2E It is there for the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * server, which uses it to bound how old a request it will=
 answer and so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* how long a captured one can be replayed=2E The reply does not echo it: a<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * client times =
the round trip itself, by the request_id=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint64_t timestamp;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    uint32_t flags; /**&lt; PROBE_REQUEST_FL=
AG_* */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/** probe reply TLV, a server&#39;s answer to a =
probe request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+str=
uct probe_reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t request_i=
d;       /**&lt; echoes the request_id of the request */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint16_t priority;         /**&lt;=
 DNS SRV style priority, lower is preferred */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint16_t weight;           /**&lt; DNS SRV s=
tyle weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int16_t max_latency_diff; /**&lt; candidate band in ms around the fastest s=
erver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** For=
 how many seconds, counted from the moment the client sent its own</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * probe request, the se=
rver will still treat this exchange as the first</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * two packets of the handshake=2E Within =
that window the client may send the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * third packet straight away instead of starting a han=
dshake of its own=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * 0 means it cannot, so it has to begin a fresh one=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t connect_lifetime;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t flags; =
/**&lt; PROBE_REPLY_FLAG_* */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Smallest on-wire value =
length (the TLV header not counted) of each TLV: the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * sizes of the fixed fields above, in wi=
re order=2E A value may be longer, which</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * is how the TLVs are extended; trailing bytes that a=
re not understood are</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * ignored on read=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** request_=
id (u64), timestamp (u64), flags (u32) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define PROBE_REQUEST_LEN ((uint16_t)(2 * sizeof(uint=
64_t) + sizeof(uint32_t)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** request_=
id (u64), then priority, weight, max_latency_diff,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * connect_lifetime and flags (u16 each) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REPLY_=
LEN ((uint16_t)(sizeof(uint64_t) + 5 * sizeof(uint16_t)))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Write a complete probe request TLV, header and value, to buf=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if buf =
has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool probe=
_request_write(struct buffer *buf, const struct probe_request *r);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Read a probe request TLV value from buf=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * buf must cover exactly the TLV&#39;s value, as ctrl=
_msg_find_tlv() returns it=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Bytes beyond the fields understood here are ignored, so a long=
er value from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a f=
uture version still parses=2E Flag bits that are not known are kept in</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * flags rather than rej=
ected, for the same reason=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn true on success, false if buf is shorter than the mandatory fields=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool probe_request_read(struct buffer=
 *buf, struct probe_request *r);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete pr=
obe reply TLV, header and value, to buf=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return true on success, false if buf has insufficient space=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool probe_reply_write(struct buffer *=
buf, const struct probe_reply *r);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe repl=
y TLV value from buf=2E The calling convention is that of</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * probe_request_read()=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * The two flag combinations the protocol rules=
 out are rejected here, since</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * neither can be acted on: a reply must not call the other addre=
sses of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * remot=
e both the same server and distinct ones, and it must not extend the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * connect_lifetime to tho=
se addresses without first calling them the same</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * server=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return true on success, false if buf is shorter than the mandatory=
 fields</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         o=
r the flags contradict each other=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool probe_reply_read(struct buffer *buf, struct probe_reply *r);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif /* ifndef PROBE_H */</span><br><span>dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index c=
a5958f=2E=2E7793c0a 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span>=
<br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3745,21 +3745,32 @@=
</span><br><span> </span><br><span> /**</span><br><span>  * Does a very coa=
rse check on the received opcode=2E It only checks if the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * opcode is an allowed op code for the=
 peer to send at all, not if this</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * opcode is valid for the current state=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * opcode is one the peer may send on t=
he reliable control channel at all,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * not if this opcode is valid for the current state=2E</sp=
an><br><span>  */</span><br><span> static bool</span><br><span> tls_pre_dec=
rypt_verify_opcode(int op, bool server, const struct link_socket_actual *fr=
om)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!opcode_is_reliable_control(o=
p))</span><br><span>     {</span><br><span>         if (op =3D=3D P_CONTROL=
_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><b=
r><span>         {</span><br><span>             msg(D_TLS_ERRORS, &quot;Pee=
r tried unsupported key-method 1&quot;);</span><br><span>         }</span><=
br><span>         struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS, &quot;TLS Error: unk=
nown opcode received from %s op=3D%d&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            print_link_socket_actual(from, &amp;gc), =
op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (op =
=3D=3D P_CONTROL_V2 || op =3D=3D P_CONTROL_WKC_V2)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* a defined opcode, just not one this pat=
h can parse */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;TLS Error: %s received from %s, which is not par=
t of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        &quot;the reliable control channel&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                packet_opcode_name(op), print=
_link_socket_actual(from, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(D_TLS_ERRORS, &quot;TLS Error: unknown opcode received from %s op=3D%=
d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     print_link_socket_actual(from, &amp;gc), op);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span>         gc_free(&=
amp;gc);</span><br><span>         return false;</span><br><span>     }</spa=
n><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec<=
/span><br><span>index dad58c3=2E=2Eb0377f3 100644</span><br><span>--- a/src=
/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><b=
r><span>@@ -174,7 +174,8 @@</span><br><span>                    bool prepen=
d_ack)</span><br><span> {</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D=
 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(opcode &gt;=3D 0 &amp;&amp; opco=
de &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* this writes the message id and ACK array, which only these op=
codes have */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(opcode_is_reliable_control(opcode));</span><br><span>     uint8_t head=
er =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><=
br><span> </span><br><span>     /* Workaround for Softether servers=2E Soft=
ether has a bug that it only</span><br><span>diff --git a/src/openvpn/ssl_p=
kt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 218c6bb=2E=2E3b45492=
 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b=
/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,11 +58,50 @@</span><br><spa=
n>  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CON=
TROL_WKC_V1 11</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* define the range of legal opcodes</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Since we do no longer support key-method 1 we =
consider</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the v1 op =
codes invalid */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Control channel packet carrying a TLV payload, e=2Eg=2E a server pro=
be=2E Framed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * like=
 P_CONTROL_V1 but without the fields of the reliability layer: a session</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * id and then the TLV=
s, with no message id and no ACK array=2E It is wrapped by</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * tls-auth or tls-crypt like any ot=
her control channel packet, and with</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * neither configured it travels unauthenticated, as they =
do=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_C=
ONTROL_V2 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Variant of P_CONTROL_V2=
 with the wrapped client key appended,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * like P_CONTROL_WKC_V1 is to P_CONTROL_V1 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_WKC_V2 13</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Is a packet with opcode op carried by the reliable co=
ntrol channel?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * These opcodes are f=
ollowed by an ACK array and a control message id, which</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * is what the reliable path reads once=
 it is past the session id=2E An opcode</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * that is not one of them has something else there: P_=
CONTROL_V2 has its TLVs=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Handing such a packet to that path would read the first bytes of =
that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * payload as a=
n ACK count and a message id, and ACK or queue whatever it made</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * of them=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * The opcodes are listed rather than bounded by a ran=
ge, so that defining one</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * does not silently add it to the set=2E Key method 1 is no longer su=
pported, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its t=
wo reset opcodes are not here, and the data channel opcodes are handled</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * before this is reach=
ed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+opcode_is_reliable_control(int =
op)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    switch (op)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case P_CONTROL_SOFT_RESET_V1:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_V1:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_ACK_V1:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_H=
ARD_RESET_CLIENT_V2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        case P_CONTROL_HARD_RESET_SERVER_V2:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case P_CONTROL_HARD_RESET_CLIENT_V3:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_W=
KC_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /=
*</span><br><span>  * Define number of buffers for send and receive in the =
reliability layer=2E</span><br><span>@@ -257,6 +296,12 @@</span><br><span> =
        case P_CONTROL_WKC_V1:</span><br><span>             return &quot;P_=
CONTROL_WKC_V1&quot;;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        case P_CONTROL_V2:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return &quot;P_CONTROL_V2&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_WKC_V2:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;P_CON=
TROL_WKC_V2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>         case P_ACK_V1:</span><br><span>             return=
 &quot;P_ACK_V1&quot;;</span><br><span> </span><br><span>diff --git a/tests=
/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>index e3404754=2E=2Eb06ae5e 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests=
/openvpn/Makefile=2Eam</span><br><span>@@ -166,6 +166,7 @@</span><br><span>=
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> pkt_testdriver_=
SOURCES =3D test_pkt=2Ec \</span><br><span> 	test_control_msg=2Ec test_cont=
rol_msg=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_=
probe=2Ec test_probe=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh mock=
_win32_execve=2Ec \</span><br><span> 	test_common=2Eh \</span><br><span> 	$=
(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span>@@ -181,6 +182=
,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/packet_id=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/platform=2Ec \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/probe=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/reliable=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=
=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b=
/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index f34bd41=2E=2E5=
609c67 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>=
@@ -45,6 +45,7 @@</span><br><span> #include &quot;reliable=2Eh&quot;</span>=
<br><span> #include &quot;siphash=2Eh&quot;</span><br><span> #include &quot=
;test_control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;test_probe=2Eh&quot;</span><br><span> </span><br><sp=
an> int</span><br><span> parse_line(const char *line, char **p, const int n=
, const char *file, const int line_num,</span><br><span>@@ -841,7 +842,21 @=
@</span><br><span>         cmocka_unit_test(test_tlv_next_walks_payload),</=
span><br><span>         cmocka_unit_test(test_tlv_next_value_truncated),</s=
pan><br><span>         cmocka_unit_test(test_tlv_header_truncated),</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test=
_tlv_write_no_room)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_tlv_write_no_room),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_r=
oundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_probe_request_wire_format),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_roun=
dtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_probe_reply_wire_format),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_forward=
_compat),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_probe_request_too_short),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_too_sho=
rt),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_probe_reply_flags_contradict),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_value_trun=
cated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_find_tlv_trailing_bytes),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_skips_option=
al_after_wanted),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_find_tlv_rejects_unknown_mandatory),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
find_tlv_rejects_duplicate),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_find_tlv_empty_payload)</span><br><s=
pan>     };</span><br><span> </span><br><span>     return cmocka_run_group_=
tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_probe=2Ec b/tests/unit_tests/openvpn/=
test_probe=2Ec</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E967252c</span><br><span>--- /dev/null</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_probe=2Ec</span><br><span>@@ -0,0 +1,425 @@</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  This program is free software; you can redistribute it and/=
or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it und=
er the terms of the GNU General Public License version 2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software =
Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dis=
tributed in the hope that it will be useful,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the imp=
lied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License=
 for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAV=
E_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control=
_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;probe=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;test_probe=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Write a probe request TLV and read it back; the fiel=
ds must survive the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * round trip and the whole buffer must be consumed=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_probe_request_roundtrip(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t probe_request in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0123456789abcd=
efULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Efl=
ags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;b=
uf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUEST_LEN);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_peek_header(&amp;b=
uf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2E=
value_len, PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(BLEN(&amp;value), PROBE_REQUEST_LEN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct probe_request out =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(probe_request_read(&amp;value, &amp=
;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(in=2Erequest_id =3D=3D out=2Erequest_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimes=
tamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* the scan consumed header and value alike */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp=
;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* The probe request wire format is locked to the field order o=
f the spec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (reque=
st_id, timestamp, flags), big-endian=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_probe_request_wire_format(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_req=
uest in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  =2Erequest_id =3D 0x1122334455667788ULL,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0102030405060708ULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-fo=
rmat off */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint8_t expected[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        0x00, 0x02,                                     /* TLV type =
2, not optional */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       0x00, 0x14,                                     /* TLV value length =
=3D 20 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x=
11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        0x01, 0x02, 0x03, 0x04, =
0x05, 0x06, 0x07, 0x08, /* timestamp */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        0x00, 0x00, 0x00, 0x00,                        =
 /* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-format =
on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, siz=
eof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Write a probe reply TLV and read it back=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct probe_reply in =3D {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =2Erequest_id =3D 0x1122334455667788ULL,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_late=
ncy_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(probe_reply_write(&amp;buf, &amp;in));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&am=
p;buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REPLY_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_peek_header(&am=
p;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REPLY);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Evalue_len, PROBE_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REPLY, &amp;value)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct probe_reply out =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pr=
obe_reply_read(&amp;value, &amp;out));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(in=2Erequest_id =3D=3D out=2Erequest_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(in=2Epriority, out=2Epriority);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(in=2Eweight, out=2Eweight);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Emax_l=
atency_diff, out=2Emax_latency_diff);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(in=2Econnect_lifetime, out=2Econnect=
_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe r=
eply wire format is locked to the field order of the spec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * (request_id, priority, weight, max=
_latency_diff, connect_lifetime, flags),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * big-endian=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_probe_reply_wire_format(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_reply in =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ereq=
uest_id =3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Epriority =3D 10,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =
=3D 30,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ef=
lags =3D PROBE_REPLY_FLAG_RESEND_WKC,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* clang-format off */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const uint8_t expected[] =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        0x00, 0x03,                                =
     /* TLV type 3, not optional */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x00, 0x12,                                     /* =
TLV value length =3D 18 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_i=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0=
x0a,                                     /* priority =3D 10 */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x64,             =
                        /* weight =3D 100 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        0x00, 0x19,                               =
      /* max_latency_diff =3D 25 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x00, 0x1e,                                     /* =
connect_lifetime =3D 30 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        0x00, 0x01,                                     /* flags =3D=
 RESEND_WKC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-forma=
t on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, s=
izeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* A TLV with a longer-than-known value must still parse=
: the known fields are</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * read and the trailing bytes are skipped=2E Flag bits we do not know a=
re kept</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rather th=
an rejected, for the same forward compatibility=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_probe_request_forward_compat(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D all=
oc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint=
16_t extended_len =3D PROBE_REQUEST_LEN + 4;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf=
, TLV_TYPE_PROBE_REQUEST, false, extended_len));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u64(&amp;buf, 7));  =
           /* request_id */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(buf_write_u64(&amp;buf, 0xdeadbeefULL)); /* timesta=
mp */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(buf_write_u32(&amp;buf, 0x80000000));    /* flags, unknown bit set */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_wri=
te_u32(&amp;buf, 0x11223344));    /* unknown trailing field */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TL=
V_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), extended_len);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct probe_request out =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_re=
quest_read(&amp;value, &amp;out));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(out=2Erequest_id =3D=3D 7);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=
=3D 0xdeadbeefULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(out=2Eflags =3D=3D 0x80000000);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* the unknown trailing field must have bee=
n consumed from the payload */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A value shorter t=
han the mandatory fields must be rejected, even when it</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * holds enough bytes for some of the i=
ndividual fields to read successfully=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_probe_request_too_short(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 8 of the 20 mandato=
ry value bytes: enough for the request_id alone */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u64(&amp;buf, 0xde=
adbeefULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_request o=
ut =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(probe_request_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The same for the =
reply, one u16 short of its 18 mandatory bytes=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_probe_reply_too_short(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_w=
rite_u64(&amp;buf, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; 4; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        assert_true(buf_write_u16(&amp;buf, 0));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct probe_reply out =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(probe_reply_read(&amp;buf, &amp;out))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* The flag combinations the protocol rules out must be rejected: the ot=
her</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * addresses of =
a remote cannot be both the same server and distinct ones, and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * a shared connect_lifetime nee=
ds them to have been called equal=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_probe_reply_flags_contradict(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint16_t bad[] =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_ADDRS=
_EQUAL | PROBE_REPLY_FLAG_PROBE_MORE,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        PROBE_REPLY_FLAG_LIFETIME_SHARED,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_LIFETIME_S=
HARED | PROBE_REPLY_FLAG_PROBE_MORE,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint16_t good[] =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        PROBE_REPLY_FLAG_ADDRS_EQUAL,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_PROBE_MORE,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_ADDRS_EQ=
UAL | PROBE_REPLY_FLAG_LIFETIME_SHARED,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (siz=
e_t i =3D 0; i &lt; SIZE(bad) + SIZE(good); i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const bool expect_ok =3D i &gt;=3D SIZE(bad);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const uint16_t fla=
gs =3D expect_ok ? good[i - SIZE(bad)] : bad[i];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct probe_=
reply in =3D { =2Erequest_id =3D 1, =2Eflags =3D flags };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        assert_true(probe_reply_write=
(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct bu=
ffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REPLY, &amp;value));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct probe_reply out =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_i=
nt_equal(probe_reply_read(&amp;value, &amp;out), expect_ok);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV header claiming mo=
re value bytes than the payload holds must be</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * rejected by the scan rather than reported as f=
ound -- for the TLV being</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * looked for as much as for one that would merely be skipped=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_value_truncated(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the wanted TLV decla=
res 20 value bytes, only 8 are present */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_write_header(&amp;buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUE=
ST_LEN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u64(&amp;buf, 0xdeadbeefULL));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, TLV=
_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* same defect on a TLV that would be skipped: the scan must not walk past<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the end of th=
e payload looking for the next header */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_write_header(&amp;buf2, 0x7ff, false, 64));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf2, =
0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(ctrl_msg_find_tlv(&amp;buf2, TLV_TYPE_PROBE_REQUEST, &amp;value));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Bytes left over after the last TLV that are too few for a header make the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * message malformed,=
 even when the wanted TLV was already found=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_find_tlv_trailing_bytes(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* 1 to 3 bytes: less than a 4-byte TLV header *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int trail=
ing =3D 1; trailing &lt; CTRL_MSG_TLV_HEADER_LEN; trailing++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(128,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 1 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_tr=
ue(probe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; trailing; i++)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            assert_true(buf_write=
_u8(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ass=
ert_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknow=
n TLV marked optional after the wanted one is skipped, and the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * wanted value is still the one=
 returned=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_skips=
_optional_after_wanted(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct probe_request in =3D {=
 =2Erequest_id =3D 1, =2Etimestamp =3D 7 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(probe_request_write(&amp;buf, &amp;=
in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf,=
 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv=
(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), PROBE_R=
EQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(probe_request_read(&amp;value, &amp;out));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Et=
imestamp =3D=3D 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* A TLV we do not know that is not marked optional ca=
rries something its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * sender requires us to act on, so the scan rejects the message whether th=
at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV comes befo=
re or after the wanted one=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_find_tlv_rejects_unknown_mandatory(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_request in =
=3D { =2Erequest_id =3D 1, =2Etimestamp =3D 7 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer before =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv=
_write_header(&amp;before, 0x7ff, false, 4));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;before, 0xcafe=
f00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(probe_request_write(&amp;before, &amp;in));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer after =3D alloc_buf_gc(128, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_=
write(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, false=
, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(buf_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(ctrl_msg_find_tlv(&amp;before, TLV_TYPE_PROBE_REQUEST,=
 &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(ctrl_msg_find_tlv(&amp;after, TLV_TYPE_PROBE_REQUEST, &amp;valu=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* The wanted TLV may occur only once: a second one rejects the messa=
ge=2E Repeats</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of =
an unknown TLV marked optional are skipped like any other=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_find_tlv_rejects_duplicate(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer val=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 probe_request in =3D { =2Erequest_id =3D 1 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv=
(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 2; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_true(ctrl_msg_tlv_write_he=
ader(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        assert_true(buf_write_u32(&amp;buf, 0));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(probe_request_write(&amp;buf, &=
amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* An empty payload holds no TLV=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_find_tlv_empty_payload(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_t=
lv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
probe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2E9c4137d</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=2Eh</=
span><br><span>@@ -0,0 +1,54 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  O=
penVPN -- An application to securely tunnel IP networks</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             session authentication and key exchange,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet en=
cryption, packet authentication, and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef TEST_PROBE_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TEST_PROBE_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void test_probe_request_roundtrip(void **state);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void test_probe_request_wire_format(void **state);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply_roundtrip(void **st=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply_wire_format=
(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_request=
_forward_compat(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_probe_request_too_short(void **state);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void test_probe_reply_too_short(void **state);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void test_probe_reply_flags_contradict(void **state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void test_find_tlv_value_truncated(void **state);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void test_find_tlv_trailing_bytes(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_find_tlv_skips_opti=
onal_after_wanted(void **state);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
est_find_tlv_rejects_unknown_mandatory(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_find_tlv_rejects_duplicate(void **state);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void test_find_tlv_empty_payload(void **state);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">=
change 1741</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/174=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 29 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Sti=
pakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Li=
ci &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: chugly &lt;charlie=2Evigue@openvpn=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--5hvcIFOrykU=--


--===============0833246332369813329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0833246332369813329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0833246332369813329==--


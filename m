Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF0606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DrkZzCAN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YlOcbSSt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D0AR4xKw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gSEF8yXF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HU0vRugJWy3PrSkI39mBWXVQwqhUn0qnWU+/DmD0jpU=; b=DrkZzCANHR17FgsrM/vs2OvCTM
	6Xck7HAiV72Pr2f36fq7w1hQj5v8iRUTb2qOJ7JzC53pz2a0ID4M8Cuh61EFJPq1Xa0KBeeomTDx0
	H0LxTQuKm2YK4+k1U4U+1yBChYG+/Jd/+zHMXzQqXOaa8hYAG21MR2G0Xkqww4w+Toz8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQK9f-000000000LK-2KE5;
	Mon, 09 Nov 2026 07:51:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQK9d-000000000L1-3RPr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 07:51:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rewhecYMsKy6dkjl7p9CxkZsx/pBusY0drrsHxbg4MQ=; b=YlOcbSStjMR1tjC831aeogPc/a
 TfT3PXgQKbKy1uNFSVZoW6puG4jMM32YLrFrksUqbFngx0zSVhewlaBrCB79cyXDV7kWUX0x66D2b
 IbUi5W06lMqh1VZj8lbOQf7opuVyrsDPDy3NDl1CRKd6ahNWYZZ5blhm85Us9cKtcv/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rewhecYMsKy6dkjl7p9CxkZsx/pBusY0drrsHxbg4MQ=; b=D0AR4xKw89U/HQUhxlecy9Utp1
 2CtrNa3RqDvycDpDmgR+pi3AmYoY+SJpAMNOPKvcDLc8zx+QyILS424WXzvBjG8S21hrSRZcwfwc/
 sSkkwmdqhBxsw6DkIjRFi3Cw8+9yM/IW1eUkBMlhvutENUGvFRG4HwDElFrAg1TsIpPk=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQK9a-000000005w8-0gBM for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 07:51:01 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-491d1f66968so18446f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 23:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794210651; x=1794815451; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rewhecYMsKy6dkjl7p9CxkZsx/pBusY0drrsHxbg4MQ=;
 b=gSEF8yXF3dQmi4KvT1kq4Ee6NgEetLDzEpgurXvtzwWaFgYKR+m0q8crQDZkpaouY5
 eWZRDVxZUfmIfUiGGgZw0Gq88/qvLeNbOzOrE/+2m0bH0aApfL1D0xSSeK90nCitltXE
 6UUbK+5dCUWyHx3h4pRQHilm3EzEgkTQG3csk5TdZxDZKXRFN1FiQdAAJDS2utnRy+Ao
 iTdKcEW5XIoYQwl3O5iM5BPVV5NdgovmUMco7A2pXFRK28lS3P3QeIXrg37MblPbHgis
 HpnTbsDffXp3WTGnoe8Z4sVTZm1nvxu0JOhg+o6pdVK5IBvn2aatvOIzdVe0ZtuTOYWp
 jEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794210651; x=1794815451;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rewhecYMsKy6dkjl7p9CxkZsx/pBusY0drrsHxbg4MQ=;
 b=YoQy56cmIv6lU15wRF0ehGm0qqLQe3K8gxzD5/Vq9t1OS3M3tz6R7lC2O3jpf5Tq/e
 uRnI7tfXRVbXqKJ4LhtJoB5bC3kLBmYXeI4lQzW/rFFvg3kZ5lcWsmYAPx9Tc4JpSzBC
 ltnd8i3+WAHi4Zul/VWxIp2AmQdbIbCcbFC4PDctHu9WPr5+0fsnkmgF5h/WINQY/btn
 IJS3cK9/aTfN+tuZPt0+93o1juyBAi2fVdflUvFX+TYWNdGNbbf+ZBwnzfZHYTUrRht7
 JvA6S6hZTaAP7vxIjz85ZsV9VEwjEwIGreAmJx59IeS1A4/i5G4KG9LyKGdUhhvfFxqZ
 fRfA==
X-Gm-Message-State: APuU4Z9bHPqaYSlEqIT2s7jHKblCjyVESoO7MAhsvDFXRu83Cw5HuMNP
 FtNNe8nJpsStzMtwcKUEh+c7DzzuIAuySWeuCSRgHIkLEstfXEQDHM1U5pN0d9C2My7UWE/Pfi0
 CFL/5h357/MhvXJ58ILmzm2rXEBw+p0PqwBCKef6Qmmob1UwfXmrPDE5jGwybxOfcAKlr
X-Gm-Gg: AYBFou2NouwILbjBAPVyOeO+ySbnegPZfVbMc5gojb/TkdxvZBSUTiUEyoZ8XgNUTkS
 oRF9XRQl0JdmH9Ga5lIlT/e0yGTj0MKolmVsCVIoOLUq+OFQYZCjQmVmzRHxz3V0AeTPKvcnS5m
 A466fjtfVBPx30oyfrdxlNdTmLy6ELct+8iEYyHKdzwXmvl6JRYAw7/hmxawbv4Zr/yg74xzu3P
 1BIjclSjsaOilR0lCQTNmlmTwr/V9ZtDsLza9eCkQ7dBdvXVO2WREvtNacIG6/MsZDfRVHMEcFu
 nbqhC++A/oObt1MI5Ja1uNiOlIrMdx052zlSKoUW9HRnDolLA0qUxCNjbvDpKHcqVXbRNpBlSBC
 iq+pht0+qBaTqpWk/dHejDurqQWc7mAvchT9NeGGmjnZWd+oi4ICB/gidbPdOFfr5Pp9hqTFBiW
 1j6lnv9dEkqNd/SRbM1XtRpc2Tftns7ZUYj/j6I3oebfD8gCxpK5jlBHylIjtMSZhQi2ec5lYpk
 qIlvuOnRtzf+w+OThaaoFS2HytaFvZXRIlurjltBU9Bdx/UElcEFLALFCW7PE5LlpZv2ZVAupZF
 t3OPcjCdKBhVGwzA+JVXgKbHdtaEtm/3dvap1UrUldudNhDbvCDmOoIXY89Q85Am67g+/DwgbyG
 4t6MpCMMrP6O8JGRyGcZs+VeXLkqX4MN0IwOlFNr8q2NawMRjkmD0gdbQ/ZRCc3Xs9lKLEmExgP
 +9KjXAreov0+2lJA==
X-Received: by 2002:a05:6000:2386:b0:48e:60ed:b012 with SMTP id
 ffacd0b85a97d-4958cd3d3e6mr6904578f8f.57.1794210651342; 
 Sun, 08 Nov 2026 23:50:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm9135376f8f.27.2026.11.08.23.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 23:50:50 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 07:50:48 +0000
To: Selva Nair <selva.nair@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: fb3162d2889759568a5887f540be5cec0786a978
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <28c4ebcce21596dd7aabf80c6f72d73592c089d9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQK9a-000000005w8-0gBM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: opidopiopi@gmail.com, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1737236677121096011=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1737236677121096011==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZJiwZBM5+p4="; charset=UTF-8

--ZJiwZBM5+p4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, opid=
opiopi@gmail=2Ecom=2E

Hello Arne Schwabe, Selva Nair, 

I'd like you to re=
examine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2148?usp=3Demail

to look at the new patch set (#4)=2E


Change subje=
ct: Implement multiline responses for pkcs11-id commands
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement multiline responses f=
or pkcs11-id commands

Responses to the management interface commands pkcs1=
1-id-[get|count] did
not follow the standard syntax, but instead looked lik=
e notifications=2E

Introduce a new management interface version so that cl=
ients announcing
versions >=3D 7 will receive responses in the new format w=
hile keeping
compatibility for older client versions=2E

If a client announ=
ces a management version >=3D 7 the responses conform to
the common multili=
ne + END syntax=2E At the same time, it is now possible
to query all PKCS#1=
1 ids using "all" or a range from "start" to
"end" - 1=2E Failures to retri=
eve an id will return a partial response
terminated by an "ERROR" message i=
ncluding the erroneous index=2E
The response format for pkcs11-id-get was c=
hanged to return a comma
separated list (index,id,cert_blob) which is easie=
r to parse=2E

Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
Signed-=
off-by: Marvin Wunderlich <opidopiopi@gmail=2Ecom>
---
M doc/management-not=
es=2Etxt
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
3 files changed,=
 164 insertions(+), 21 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/48/2148/4

diff --git a/doc/management-notes=
=2Etxt b/doc/management-notes=2Etxt
index 6c798c0=2E=2E42ea644 100644
--- a=
/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -617,23 +61=
7,109 @@
 COMMAND -- pkcs11-id-count  (OpenVPN 2=2E1 or higher)
 ----------=
-----------------------------------------
 
-Retrieve available number of c=
ertificates=2E
+Retrieve available number of PKCS#11 certificates=2E
+
+For=
 management client versions <7:
+
+     pkcs11-id-count
+
+The reply is ">P=
KCS11ID-COUNT:<count>"=2E
 
 Example:
 
      pkcs11-id-count
      >PKCS11=
ID-COUNT:5
 
+For management client versions >=3D 7:
+
+     pkcs11-id-coun=
t
+
+The reply is a decimal count followed by "END" on a separate line=2E
+=

+Example:
+
+     pkcs11-id-count
+     5
+     END
+
 COMMAND -- pkcs11-i=
d-get  (OpenVPN 2=2E1 or higher)
 -----------------------------------------=
--------
 
+Retrieve PKCS#11 certificates=2E
+
+For management client versi=
ons < 7:
+
+  pkcs11-id-get <index>
+
 Retrieve certificate by index, the I=
D string should be provided
 as PKCS#11 identity, the blob is a base 64 enc=
oded certificate=2E
 
 Example:
 
      pkcs11-id-get 1
-     PKCS11ID-ENTR=
Y:'1', ID:'<snip>', BLOB:'<snip>'
+     >PKCS11ID-ENTRY:'1', ID:'<id>', BLO=
B:'<blob>'
+
+For management client versions >=3D 7:
+
+  pkcs11-id-get <in=
dex>
+  pkcs11-id-get <start> <end>
+  pkcs11-id-get all
+
+Retrieve a sing=
le PKCS#11 certificate at index <index> or multiple
+PKCS#11 certificates f=
rom index <start> to <end>-1=2E Alternatively
+<start> =3D "all" retrieves =
all PKCS#11 certificates=2E A comma separated
+list including index, PKCS#1=
1 id and the base 64 encoded certificate
+will be returned=2E If any id ret=
rieval results in a failure, the returned
+list will be partial and termina=
ted by "ERROR: =2E=2E" instead of "END"=2E
+The "ERROR" message will includ=
e the index of failure=2E
+
+Example 1:
+
+  Management interface client se=
nds:
+
+    pkcs11-id-get 1
+
+  OpenVPN daemon responds with:
+
+    1,<id=
>,<blob>
+    END
+
+Example 2:
+
+  Management interface client sends:
+
+=
    pkcs11-id-get 1 3
+
+  OpenVPN daemon responds with:
+
+    1,<id_a>,<b=
lob_a>
+    2,<id_b>,<blob_b>
+    END
+
+Example 3:
+
+  Management interf=
ace client sends:
+
+    pkcs11-id-get all
+
+  OpenVPN daemon with 3 PKCS#=
11 certificates responds with:
+
+    0,<id_a>,<blob_a>
+    1,<id_b>,<blob=
_b>
+    2,<id_c>,<blob_c>
+    END
+
+Example 4:
+
+  Management interface=
 client sends:
+
+    pkcs11-id-get all
+
+  OpenVPN daemon with 3 PKCS#11 =
certificates fails to retrieve index 1
+
+    0,<id_a>,<blob_a>
+    ERROR:=
 Failed to load PKCS#11 id at index: 1
+
 
 COMMAND -- client-auth  (OpenVP=
N 2=2E1 or higher)
 -----------------------------------------------
@@ -124=
0,7 +1326,7 @@
     "ERROR: [text]"=2E
 
 (2) For commands which print mult=
iple lines of output,
-    the last line will be "END"=2E
+    the last lin=
e will be "END" or "ERROR: [text]"=2E
 
 (3) Real-time messages will be in =
the form ">[source]:[text]",
     where source is "CLIENT", "ECHO", "FATAL"=
, "HOLD", "INFO", "LOG",
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/=
manage=2Ec
index 58f63e6=2E=2Ef00eb30 100644
--- a/src/openvpn/manage=2Ec
+=
++ b/src/openvpn/manage=2Ec
@@ -74,6 +74,7 @@
     MCV_USERNAME_ONLY =3D 4,=

     MCV_MULTILINE_PASSWORD =3D 5,
     MCV_PREFERRED_USERNAME =3D 6,
+   =
 MCV_MULTILINE_PKCS11_RESPONSE =3D 7,
 };
 
 struct management *management;=
 /* GLOBAL */
@@ -120,7 +121,8 @@
     msg(M_CLIENT, "pid                  =
  : Show process ID of the current OpenVPN process=2E");
 #ifdef ENABLE_PKC=
S11
     msg(M_CLIENT, "pkcs11-id-count        : Get number of available PK=
CS#11 identities=2E");
-    msg(M_CLIENT, "pkcs11-id-get index    : Get PKC=
S#11 identity at index=2E");
+    msg(M_CLIENT, "pkcs11-id-get i|all [j] : =
Get PKCS#11 identity at index =3D i=2E");
+    msg(M_CLIENT, "             =
             For version >=3D 7 also i to j-1 or all=2E");
 #endif
     msg=
(M_CLIENT, "client-auth CID KID    : Authenticate client-id/key-id CID/KID =
(MULTILINE)");
     msg(M_CLIENT, "client-auth-nt CID KID : Authenticate cl=
ient-id/key-id CID/KID");
@@ -894,26 +896,81 @@
 static void
 man_pkcs11_id=
_count(const struct management *man)
 {
-    msg(M_CLIENT, ">PKCS11ID-COUNT=
:%d", pkcs11_management_id_count());
-}
-
-static void
-man_pkcs11_id_get(s=
truct management *man, const int index)
-{
-    char *id =3D NULL;
-    cha=
r *base64 =3D NULL;
-
-    if (pkcs11_management_id_get(index, &id, &base64=
))
+    if (man->connection=2Eclient_version >=3D MCV_MULTILINE_PKCS11_RESP=
ONSE)
     {
-        msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d', ID:'%s', BLOB:'%=
s'", index, id, base64);
+        msg(M_CLIENT, "%d", pkcs11_management_id_=
count());
+        msg(M_CLIENT, "END");
     }
     else
     {
-        m=
sg(M_CLIENT, ">PKCS11ID-ENTRY:'%d'", index);
+        msg(M_CLIENT, ">PKCS1=
1ID-COUNT:%d", pkcs11_management_id_count());
+    }
+}
+
+static void
+man=
_pkcs11_id_get(struct management *man, const char *p1, const char *p2)
+{
+=
    ASSERT(p1);
+
+    if ((streq(p1, "all") || p2 !=3D NULL) && man->conne=
ction=2Eclient_version < MCV_MULTILINE_PKCS11_RESPONSE)
+    {
+        msg=
(M_CLIENT, "ERROR: Listing multiple ids is only supported for version >=3D =
%d", MCV_MULTILINE_PKCS11_RESPONSE);
+        return;
     }
 
-    free(id=
);
-    free(base64);
+    if (man->connection=2Eclient_version >=3D MCV_MU=
LTILINE_PKCS11_RESPONSE)
+    {
+        unsigned int count =3D pkcs11_mana=
gement_id_count();
+        unsigned int from =3D (unsigned int)atoi(p1);
+=
        unsigned int to =3D p2 ? (unsigned int)atoi(p2) : from + 1;
+
+    =
    if (streq(p1, "all"))
+        {
+            from =3D 0;
+            =
to =3D count;
+        }
+
+        bool error =3D false;
+        for (uns=
igned int i =3D from; i < min_uint(to, count) && !error; i++)
+        {
+ =
           char *id =3D NULL;
+            char *base64 =3D NULL;
+
+      =
      if (pkcs11_management_id_get(i, &id, &base64))
+            {
+      =
          msg(M_CLIENT, "%u,%s,%s", i, id, base64);
+            }
+       =
     else
+            {
+                error =3D true;
+                =
msg(M_CLIENT, "ERROR: Failed to load PKCS#11 id at index: %u", i);
+       =
     }
+            free(id);
+            free(base64);
+        }
+      =
  if (!error)
+        {
+            msg(M_CLIENT, "END");
+        }
+   =
 }
+    else
+    {
+        int index =3D atoi(p1);
+
+        char *id =
=3D NULL;
+        char *base64 =3D NULL;
+
+        if (pkcs11_management_=
id_get(index, &id, &base64))
+        {
+            msg(M_CLIENT, ">PKCS11=
ID-ENTRY:'%d', ID:'%s', BLOB:'%s'", index, id, base64);
+        }
+       =
 else
+        {
+            msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d'", index);=

+        }
+        free(id);
+        free(base64);
+    }
 }
 
 #endif /=
* ifdef ENABLE_PKCS11 */
@@ -1838,9 +1895,9 @@
     }
     else if (streq(p=
[0], "pkcs11-id-get"))
     {
-        if (man_need(p, 1, 0))
+        if (=
man_need(p, 1, MN_AT_LEAST))
         {
-            man_pkcs11_id_get(man,=
 atoi(p[1]));
+            man_pkcs11_id_get(man, p[1], p[2]);
         }
 =
    }
 #endif
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
=
index 82c0caa=2E=2E1d2aff1 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/op=
envpn/manage=2Eh
@@ -50,7 +50,7 @@
 #include "socket_util=2Eh"
 #include "m=
route=2Eh"
 
-#define MANAGEMENT_VERSION                  6
+#define MANAGE=
MENT_VERSION                  7
 #define MANAGEMENT_N_PASSWORD_RETRIES     =
  3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100
 #define MANAGEMENT_EC=
HO_BUFFER_SIZE         100

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2148?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
Gerrit-Change-Number:=
 2148
Gerrit-PatchSet: 4
Gerrit-Owner: opidopiopi@gmail=2Ecom
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Selva Nair <=
selva=2Enair@gmail=2Ecom>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: opidopi=
opi@gmail=2Ecom
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--ZJiwZBM5+p4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, opidopiopi@gmail=2Ec=
om=2E </p>
<p>opidopiopi@gmail=2Ecom <strong>uploaded patch set #4</strong>=
 to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2148?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Implement multiline =
responses for pkcs11-id commands<br><br>Responses to the management interfa=
ce commands pkcs11-id-[get|count] did<br>not follow the standard syntax, bu=
t instead looked like notifications=2E<br><br>Introduce a new management in=
terface version so that clients announcing<br>versions &gt;=3D 7 will recei=
ve responses in the new format while keeping<br>compatibility for older cli=
ent versions=2E<br><br>If a client announces a management version &gt;=3D 7=
 the responses conform to<br>the common multiline + END syntax=2E At the sa=
me time, it is now possible<br>to query all PKCS#11 ids using &quot;all&quo=
t; or a range from &quot;start&quot; to<br>&quot;end&quot; - 1=2E Failures =
to retrieve an id will return a partial response<br>terminated by an &quot;=
ERROR&quot; message including the erroneous index=2E<br>The response format=
 for pkcs11-id-get was changed to return a comma<br>separated list (index,i=
d,cert_blob) which is easier to parse=2E<br><br>Change-Id: I09e55085cde6dbc=
0040e111a42128527d59832b8<br>Signed-off-by: Marvin Wunderlich &lt;opidopiop=
i@gmail=2Ecom&gt;<br>---<br>M doc/management-notes=2Etxt<br>M src/openvpn/m=
anage=2Ec<br>M src/openvpn/manage=2Eh<br>3 files changed, 164 insertions(+)=
, 21 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/48/2148/4</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/manag=
ement-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 6c798c=
0=2E=2E42ea644 100644</span><br><span>--- a/doc/management-notes=2Etxt</spa=
n><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -617,23 +61=
7,109 @@</span><br><span> COMMAND -- pkcs11-id-count  (OpenVPN 2=2E1 or hig=
her)</span><br><span> ---------------------------------------------------</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Retri=
eve available number of certificates=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Retrieve available number of PKCS#11 certificates=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+For management client versions &lt;7:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     pkcs11-id-count</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+The reply is &quot;&gt;PKCS11ID-COUNT:&lt;count&gt;&quot;=
=2E</span><br><span> </span><br><span> Example:</span><br><span> </span><br=
><span>      pkcs11-id-count</span><br><span>      &gt;PKCS11ID-COUNT:5</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+For m=
anagement client versions &gt;=3D 7:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   pkcs11-id-count</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+The reply is a decim=
al count followed by &quot;END&quot; on a separate line=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Example:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     pkcs1=
1-id-count</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     5</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     END</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- pkcs=
11-id-get  (OpenVPN 2=2E1 or higher)</span><br><span> ---------------------=
----------------------------</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+Retrieve PKCS#11 certificates=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+For management client versions &lt; 7:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  pkcs11-id-get &lt;index&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> Retrieve certificate by in=
dex, the ID string should be provided</span><br><span> as PKCS#11 identity,=
 the blob is a base 64 encoded certificate=2E</span><br><span> </span><br><=
span> Example:</span><br><span> </span><br><span>      pkcs11-id-get 1</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     PKCS11ID-ENTRY:&#39;1=
&#39;, ID:&#39;&lt;snip&gt;&#39;, BLOB:&#39;&lt;snip&gt;&#39;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     &gt;PKCS11ID-ENTRY:&#39;1&#3=
9;, ID:&#39;&lt;id&gt;&#39;, BLOB:&#39;&lt;blob&gt;&#39;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+For management client versions &gt;=3D 7:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  pkcs11-id-get &lt;index&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  pkcs11-id-get &lt;start&gt; &lt;end&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id-get all</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Retrieve a single PKCS#11 certificate at =
index &lt;index&gt; or multiple</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+PKCS#11 certificates from index &lt;start&gt; to &lt;end&gt;-1=
=2E Alternatively</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&l=
t;start&gt; =3D &quot;all&quot; retrieves all PKCS#11 certificates=2E A com=
ma separated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+list in=
cluding index, PKCS#11 id and the base 64 encoded certificate</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+will be returned=2E If any id ret=
rieval results in a failure, the returned</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+list will be partial and terminated by &quot;ERROR: =
=2E=2E&quot; instead of &quot;END&quot;=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+The &quot;ERROR&quot; message will include the index=
 of failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 1:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Management interface client sends:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    pkcs11-id-get 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  OpenVPN daemon responds with:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    1=
,&lt;id&gt;,&lt;blob&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+Example 2:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  Management interface client sends:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    pkcs11-id-get 1 3</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  OpenVPN daemon responds with:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    1=
,&lt;id_a&gt;,&lt;blob_a&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    2,&lt;id_b&gt;,&lt;blob_b&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    END</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Example =
3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Management interface client sends:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id-get all</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  OpenVPN daemon with 3 PKCS#11 certificates responds w=
ith:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    0,&lt;id_a&gt;,&lt;blob_a&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    1,&lt;id_b&gt;,&=
lt;blob_b&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    2,=
&lt;id_c&gt;,&lt;blob_c&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 4:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  Management interface client sends:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    pkcs11-id-get all</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  OpenVPN daemon with 3 PKCS#11 certificates fails to retrieve index 1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0,&lt;id_a&gt;,&lt;blob_a&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ERROR: Failed to loa=
d PKCS#11 id at index: 1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> </span><br><span> COMMAND -- client-auth  (OpenVPN 2=
=2E1 or higher)</span><br><span> ------------------------------------------=
-----</span><br><span>@@ -1240,7 +1326,7 @@</span><br><span>     &quot;ERRO=
R: [text]&quot;=2E</span><br><span> </span><br><span> (2) For commands whic=
h print multiple lines of output,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    the last line will be &quot;END&quot;=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    the last line will be &quot;END&qu=
ot; or &quot;ERROR: [text]&quot;=2E</span><br><span> </span><br><span> (3) =
Real-time messages will be in the form &quot;&gt;[source]:[text]&quot;,</sp=
an><br><span>     where source is &quot;CLIENT&quot;, &quot;ECHO&quot;, &qu=
ot;FATAL&quot;, &quot;HOLD&quot;, &quot;INFO&quot;, &quot;LOG&quot;,</span>=
<br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</spa=
n><br><span>index 58f63e6=2E=2Ef00eb30 100644</span><br><span>--- a/src/ope=
nvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><spa=
n>@@ -74,6 +74,7 @@</span><br><span>     MCV_USERNAME_ONLY =3D 4,</span><br=
><span>     MCV_MULTILINE_PASSWORD =3D 5,</span><br><span>     MCV_PREFERRE=
D_USERNAME =3D 6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  MCV_MULTILINE_PKCS11_RESPONSE =3D 7,</span><br><span> };</span><br><span>=
 </span><br><span> struct management *management; /* GLOBAL */</span><br><s=
pan>@@ -120,7 +121,8 @@</span><br><span>     msg(M_CLIENT, &quot;pid       =
             : Show process ID of the current OpenVPN process=2E&quot;);</s=
pan><br><span> #ifdef ENABLE_PKCS11</span><br><span>     msg(M_CLIENT, &quo=
t;pkcs11-id-count        : Get number of available PKCS#11 identities=2E&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_CLIENT=
, &quot;pkcs11-id-get index    : Get PKCS#11 identity at index=2E&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &qu=
ot;pkcs11-id-get i|all [j] : Get PKCS#11 identity at index =3D i=2E&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &=
quot;                          For version &gt;=3D 7 also i to j-1 or all=
=2E&quot;);</span><br><span> #endif</span><br><span>     msg(M_CLIENT, &quo=
t;client-auth CID KID    : Authenticate client-id/key-id CID/KID (MULTILINE=
)&quot;);</span><br><span>     msg(M_CLIENT, &quot;client-auth-nt CID KID :=
 Authenticate client-id/key-id CID/KID&quot;);</span><br><span>@@ -894,26 +=
896,81 @@</span><br><span> static void</span><br><span> man_pkcs11_id_count=
(const struct management *man)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&q=
uot;, pkcs11_management_id_count());</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id_get(struct management =
*man, const int index)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *id =3D NU=
LL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *base64 =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (pkcs11_management_id_get(=
index, &amp;id, &amp;base64))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (man-&gt;connection=2Eclient_version &gt;=3D MCV_MULTILINE=
_PKCS11_RESPONSE)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_CLIENT, &quot;&gt;PKCS11ID-ENTRY:&#39;%d&#=
39;, ID:&#39;%s&#39;, BLOB:&#39;%s&#39;&quot;, index, id, base64);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;=
%d&quot;, pkcs11_management_id_count());</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_CLIENT, &quot;END&quot;);</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quot;&gt;PKCS11I=
D-ENTRY:&#39;%d&#39;&quot;, index);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, pk=
cs11_management_id_count());</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+man_pkcs11_id_get(struct management *man, const c=
har *p1, const char *p2)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(p1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if ((streq(p1, &quot;all&quot;) =
|| p2 !=3D NULL) &amp;&amp; man-&gt;connection=2Eclient_version &lt; MCV_MU=
LTILINE_PKCS11_RESPONSE)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_CLIENT, &quot;ERROR: Listing multiple ids is only supported for versio=
n &gt;=3D %d&quot;, MCV_MULTILINE_PKCS11_RESPONSE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fr=
ee(id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(base6=
4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (man-&gt;=
connection=2Eclient_version &gt;=3D MCV_MULTILINE_PKCS11_RESPONSE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        unsigned int count =3D pkcs11_man=
agement_id_count();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        unsigned int from =3D (unsigned int)atoi(p1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        unsigned int to =3D p2 ? (unsigne=
d int)atoi(p2) : from + 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
streq(p1, &quot;all&quot;))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          from =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            to =3D count;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool error =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
or (unsigned int i =3D from; i &lt; min_uint(to, count) &amp;&amp; !error; =
i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            char *id =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ch=
ar *base64 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (pk=
cs11_management_id_get(i, &amp;id, &amp;base64))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                msg(M_CLIENT, &quot;%u,%s,%s&quot;, =
i, id, base64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                err=
or =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         msg(M_CLIENT, &quot;ERROR: Failed to load PKCS#11 id at index: %u&=
quot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fre=
e(id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            f=
ree(base64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!erro=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &=
quot;END&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        int index =3D atoi(p1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        char *id =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        char *base64 =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (pkcs11_management_id_get(index, &amp;id, &amp;ba=
se64))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIEN=
T, &quot;&gt;PKCS11ID-ENTRY:&#39;%d&#39;, ID:&#39;%s&#39;, BLOB:&#39;%s&#39=
;&quot;, index, id, base64);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
CLIENT, &quot;&gt;PKCS11ID-ENTRY:&#39;%d&#39;&quot;, index);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        free(id);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        free(base64);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </=
span><br><span> #endif /* ifdef ENABLE_PKCS11 */</span><br><span>@@ -1838,9=
 +1895,9 @@</span><br><span>     }</span><br><span>     else if (streq(p[0]=
, &quot;pkcs11-id-get&quot;))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (man_need(p, 1, 0))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT=
_LEAST))</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            man_pkcs11_id_get(man, atoi(p[1]));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            man_pkcs11_id_get(man=
, p[1], p[2]);</span><br><span>         }</span><br><span>     }</span><br>=
<span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/ope=
nvpn/manage=2Eh</span><br><span>index 82c0caa=2E=2E1d2aff1 100644</span><br=
><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manag=
e=2Eh</span><br><span>@@ -50,7 +50,7 @@</span><br><span> #include &quot;soc=
ket_util=2Eh&quot;</span><br><span> #include &quot;mroute=2Eh&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MAN=
AGEMENT_VERSION                  6</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define MANAGEMENT_VERSION                  7</span><br><spa=
n> #define MANAGEMENT_N_PASSWORD_RETRIES       3</span><br><span> #define M=
ANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100</span><br><span> #define MANAGEMENT_=
ECHO_BUFFER_SIZE         100</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 2148</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0=
9e55085cde6dbc0040e111a42128527d59832b8 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2148 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=
=2Ecom </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: opidopiopi@gmail=2Ecom </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ZJiwZBM5+p4=--


--===============1737236677121096011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1737236677121096011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1737236677121096011==--


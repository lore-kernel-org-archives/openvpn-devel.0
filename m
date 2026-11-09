Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4B606A338
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XjoLH8Wf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S2xfrnSo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=avcPg8Pr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W/uVw1qG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nwwkDFLfdqrkZPT0utdbfD2adwPQ46XvtNjfLoft0ic=; b=XjoLH8WfsTuAmKjUIYDjPWS5y8
	xj7K4yN2wAk6IqEeJ4osLgBh86HJ22C1TOVGEgma5lcDpF3zpjtc0QDewW6Ym8MmPP+07545UeTAb
	+rHFDPs4bwDTWTYJqHAamd51hKGb+L7Ug6s/6PS/oUCi6/bU+YQRli50jVCowehChC1E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQTnn-000000003ig-3BLP;
	Mon, 09 Nov 2026 18:09:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQTne-000000003iM-2SdG
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 18:08:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bWNj834zw5Atz2ZyjTuv0vJUvH9IPyXMP24p+VhogcU=; b=S2xfrnSoaBHzjWkMSf2NYJge/r
 U/XGXzmJ5ek6GHs4dPtxL8HDffgfqjpJHhN20n9qGByl5JlPdLNePjTNHxfQ/phPgNF3lI5GK/nvs
 B6Sunl6YsrQz0BVlaoFoazA1Puo+3siHUjZN5L669jmJXPvPU5VC5bcPDad02zU7wxqE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bWNj834zw5Atz2ZyjTuv0vJUvH9IPyXMP24p+VhogcU=; b=avcPg8PrOaAvtFbmapXeCjHSbA
 gtq5GTjBuyfgD9f4zGL2r8e4LR9q+RvkK0YSl7M43H/GRL3qe58ybHgZw5fSYwQlvlBnRGY39JGuj
 dEG29U2bU7gjDAFd4z+1DPwWRsqQbwVHWusXw59+Iy9ro59pk+GQKO5nCxfAYw/G+INw=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQTnc-000000005wh-0QQ9 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 18:08:58 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso9260465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794247729; x=1794852529; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bWNj834zw5Atz2ZyjTuv0vJUvH9IPyXMP24p+VhogcU=;
 b=W/uVw1qGO74xygRVp8c7HoKecZX8jeBB8je+VWG9xOZyGkdNra9Bfi89s+4LPE8N8P
 NUmzqTC//v37ZbiAu7mcAe5ZbxfgW8FbDca7F7rdQ5bdDdODRtP/ahqcGN1yybLHUx0/
 vGuFcTnRG2NYhITQoF8MyLrVvA/IAfuNIoiHUcM/TLRzdhKu5BMfX3E5HIq2Fk+IZhV4
 RTytE6w3lCVFO9+W1NoB7upKAEyYomP52lGPNfXdIWdnKxw23sNCz0ry6f1ntLCFG/K3
 NNLLtXWlK/KNWDlabUkrkuGDgTtk5gPbEmLt9uDKbLTbjCMNgGMg0uGbbFS09EeJSJZM
 BsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794247729; x=1794852529;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bWNj834zw5Atz2ZyjTuv0vJUvH9IPyXMP24p+VhogcU=;
 b=1QQJDAsyNdiN+9MD+usfaf1+uxJh6xiSM+C7WLr7Gwzfbz4BUKAY9WOtOijPQ9OeG3
 ObkxuEspvvhAhNhlftI6MbTreg0k99FZE6n6f2VI6jX3JoFBRcqIp323vXou70+UeESj
 Zrs0Wl8G50OW9xg8Iz7ImicmDtGMPeSNqOn1H5VEszNzYhg5jccNxk5WH9pCDihsPLsz
 /6BjRrVVBBh5RlTShwIIdxrCLN8kmMfeVbNq3AOKuCMrOqe/5GG1SJu+syUL07HcD0Ea
 iWwFDCT2iIXAhdRhh+Q2R7ln/lqGeQS9rtPK5PBsNblxgRMlHJBf2KQkQQa+ZZOF3wRA
 fKwA==
X-Gm-Message-State: APuU4Z+2N4rbkUTIba9touSqvVLcQei46UdtZ9ncttGxhA0n/bL6lKWO
 ztC5KgTYubMh1qhuyiAcobO8YXPoRefsMwo4Up0VqP85JW1EAQ9/WIof3wsVV9AKGXT8+SyRq43
 71Xuc+6L0UgcFAcr9nAqtzd7Z9jTaua7fPTC/50Vx4TKdSlWRJaVU3iO20VWm2Uh5pQgt
X-Gm-Gg: AYBFou2y/nY5uLQzbRrDZsZWPBJYmeZq0fhfa3grejV7h71l6bz/ZEWLl8hElBu0Rxx
 cxg6eaQH50DmvLRawIxkrjjMi2PeaLtrAoWYlURIaMDWHvoqyU5c6/mHtiVf2el0Jc3Wu4kY4+t
 V7X7KhRzSfr9LMS8rXIcoQMzDuhM5yxI9kj6ZcVg8N5EE36ZicptOKSUWAVs1/Kh44Igq480FSN
 3wCX+8JAygok7HVdJLm2C1FyPCVrhcqCR5j4/ziSpBiF5VUcQgovBYxjGCmKTPmB2dxphyVITBi
 5hvaVoXDzhOZ2QYwBqfE8ZKA//XQ/RLP6U46BmgC7lO8Krv5QskbjMwlI8kVHBYlPSnlh+hOzVP
 bTvh8Gv8ZyxoXR3/Lgd1uK9G8nSxowk0FnOWrm1TFiuuydQ0oaHxPi9/EZYWIm+BqkkUePA/5O4
 vvKcIdrdP1OHANillT0rvp9kWQByhX3OBTTl4MwLANvafEWvV2dkI81ZxCxRv99Q77d34Wvy0C2
 4XgqinC6U3/+4HEJUWKHcpSFNo4o7UU9LiRR0xLuFmBnUffR6dUEdBwuQFIPOZw2MYxH8+71py8
 HCHZ+qVxCiXx083av3679smx7Fi/89vlvAJAm2i3PkElQqxqWvbYpPwQqxbS/zEPP7dmeJry6B6
 Nk3kQltIXHpgvubZkzTxcC9yT9LZWlTyQMYW46/sYj+O2k373uatHwLs7nGzWRR9DjljBviJvDL
 t+OtVV5lfmudZkPGo6OPR+q2mKgwgLKc7z/Ws=
X-Received: by 2002:a05:600c:1c02:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ba0230cc8emr1261535e9.2.1794247728891; 
 Mon, 09 Nov 2026 10:08:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba022fbf75sm1050615e9.0.2026.11.09.10.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:08:48 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 18:08:46 +0000
To: Selva Nair <selva.nair@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 4dbf91671cf640541f6e33e16ff487cb42818e14
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9eb9f0167825cf762bf8801fc906fd04d8b97948-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQTnc-000000005wh-0QQ9
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
 yura.uddr@gmail.com, gert@greenie.muc.de
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 Yuriy Darnobyt <yura.uddr@gmail.com>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4505829831644319515=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4505829831644319515==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R/9BqvPe9K4="; charset=UTF-8

--R/9BqvPe9K4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, Yuriy Darnobyt, opidopiopi@gmail=2Ecom=2E

Hello Arne Schwabe, Se=
lva Nair, 

I'd like you to reexamine a change=2E Please visit

    https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail

to look at the new pa=
tch set (#6)=2E

The change is no longer submittable: checks~ChecksSubmitRu=
le is unsatisfied now=2E


Change subject: Implement multiline responses fo=
r pkcs11-id commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Implement multiline responses for pkcs11-id commands

Responses to =
the management interface commands pkcs11-id-[get|count] did
not follow the =
standard syntax, but instead looked like notifications=2E

Introduce a new =
management interface version so that clients announcing
versions >=3D 7 wil=
l receive responses in the new format while keeping
compatibility for older=
 client versions=2E

If a client announces a management version >=3D 7 the =
responses conform to
the common multiline + END syntax=2E At the same time,=
 it is now possible
to query all PKCS#11 ids using "all" or a range from "s=
tart" to
"end" - 1=2E Failures to retrieve an id will return a partial resp=
onse
terminated by an "ERROR" message including the erroneous index=2E
The =
response format for pkcs11-id-get was changed to return a comma
separated l=
ist (index,id,cert_blob) which is easier to parse=2E

Change-Id: I09e55085c=
de6dbc0040e111a42128527d59832b8
Signed-off-by: Marvin Wunderlich <opidopiop=
i@gmail=2Ecom>
---
M doc/management-notes=2Etxt
M src/openvpn/manage=2Ec
M =
src/openvpn/manage=2Eh
3 files changed, 164 insertions(+), 21 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/214=
8/6

diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
i=
ndex 6c798c0=2E=2E42ea644 100644
--- a/doc/management-notes=2Etxt
+++ b/doc=
/management-notes=2Etxt
@@ -617,23 +617,109 @@
 COMMAND -- pkcs11-id-count =
 (OpenVPN 2=2E1 or higher)
 -----------------------------------------------=
----
 
-Retrieve available number of certificates=2E
+Retrieve available nu=
mber of PKCS#11 certificates=2E
+
+For management client versions <7:
+
+  =
   pkcs11-id-count
+
+The reply is ">PKCS11ID-COUNT:<count>"=2E
 
 Example:=

 
      pkcs11-id-count
      >PKCS11ID-COUNT:5
 
+For management client v=
ersions >=3D 7:
+
+     pkcs11-id-count
+
+The reply is a decimal count fol=
lowed by "END" on a separate line=2E
+
+Example:
+
+     pkcs11-id-count
+ =
    5
+     END
+
 COMMAND -- pkcs11-id-get  (OpenVPN 2=2E1 or higher)
 ---=
----------------------------------------------
 
+Retrieve PKCS#11 certific=
ates=2E
+
+For management client versions < 7:
+
+  pkcs11-id-get <index>
+=

 Retrieve certificate by index, the ID string should be provided
 as PKCS#=
11 identity, the blob is a base 64 encoded certificate=2E
 
 Example:
 
   =
   pkcs11-id-get 1
-     PKCS11ID-ENTRY:'1', ID:'<snip>', BLOB:'<snip>'
+  =
   >PKCS11ID-ENTRY:'1', ID:'<id>', BLOB:'<blob>'
+
+For management client v=
ersions >=3D 7:
+
+  pkcs11-id-get <index>
+  pkcs11-id-get <start> <end>
+=
  pkcs11-id-get all
+
+Retrieve a single PKCS#11 certificate at index <inde=
x> or multiple
+PKCS#11 certificates from index <start> to <end>-1=2E Alter=
natively
+<start> =3D "all" retrieves all PKCS#11 certificates=2E A comma s=
eparated
+list including index, PKCS#11 id and the base 64 encoded certific=
ate
+will be returned=2E If any id retrieval results in a failure, the retu=
rned
+list will be partial and terminated by "ERROR: =2E=2E" instead of "EN=
D"=2E
+The "ERROR" message will include the index of failure=2E
+
+Example =
1:
+
+  Management interface client sends:
+
+    pkcs11-id-get 1
+
+  Open=
VPN daemon responds with:
+
+    1,<id>,<blob>
+    END
+
+Example 2:
+
+  =
Management interface client sends:
+
+    pkcs11-id-get 1 3
+
+  OpenVPN da=
emon responds with:
+
+    1,<id_a>,<blob_a>
+    2,<id_b>,<blob_b>
+    EN=
D
+
+Example 3:
+
+  Management interface client sends:
+
+    pkcs11-id-ge=
t all
+
+  OpenVPN daemon with 3 PKCS#11 certificates responds with:
+
+   =
 0,<id_a>,<blob_a>
+    1,<id_b>,<blob_b>
+    2,<id_c>,<blob_c>
+    END
+=

+Example 4:
+
+  Management interface client sends:
+
+    pkcs11-id-get a=
ll
+
+  OpenVPN daemon with 3 PKCS#11 certificates fails to retrieve index =
1
+
+    0,<id_a>,<blob_a>
+    ERROR: Failed to load PKCS#11 id at index: =
1
+
 
 COMMAND -- client-auth  (OpenVPN 2=2E1 or higher)
 -----------------=
------------------------------
@@ -1240,7 +1326,7 @@
     "ERROR: [text]"=
=2E
 
 (2) For commands which print multiple lines of output,
-    the last=
 line will be "END"=2E
+    the last line will be "END" or "ERROR: [text]"=
=2E
 
 (3) Real-time messages will be in the form ">[source]:[text]",
     =
where source is "CLIENT", "ECHO", "FATAL", "HOLD", "INFO", "LOG",
diff --gi=
t a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 58f63e6=2E=2Ef00e=
b30 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -74=
,6 +74,7 @@
     MCV_USERNAME_ONLY =3D 4,
     MCV_MULTILINE_PASSWORD =3D 5=
,
     MCV_PREFERRED_USERNAME =3D 6,
+    MCV_MULTILINE_PKCS11_RESPONSE =3D=
 7,
 };
 
 struct management *management; /* GLOBAL */
@@ -120,7 +121,8 @@
=
     msg(M_CLIENT, "pid                    : Show process ID of the current=
 OpenVPN process=2E");
 #ifdef ENABLE_PKCS11
     msg(M_CLIENT, "pkcs11-id-=
count        : Get number of available PKCS#11 identities=2E");
-    msg(M_=
CLIENT, "pkcs11-id-get index    : Get PKCS#11 identity at index=2E");
+    =
msg(M_CLIENT, "pkcs11-id-get i|all [j] : Get PKCS#11 identity at index =3D =
i=2E");
+    msg(M_CLIENT, "                          For version >=3D 7 al=
so i to j-1 or all=2E");
 #endif
     msg(M_CLIENT, "client-auth CID KID   =
 : Authenticate client-id/key-id CID/KID (MULTILINE)");
     msg(M_CLIENT, =
"client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
@@ -894,=
26 +896,81 @@
 static void
 man_pkcs11_id_count(const struct management *ma=
n)
 {
-    msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count()=
);
-}
-
-static void
-man_pkcs11_id_get(struct management *man, const int i=
ndex)
-{
-    char *id =3D NULL;
-    char *base64 =3D NULL;
-
-    if (pkc=
s11_management_id_get(index, &id, &base64))
+    if (man->connection=2Eclie=
nt_version >=3D MCV_MULTILINE_PKCS11_RESPONSE)
     {
-        msg(M_CLIENT=
, ">PKCS11ID-ENTRY:'%d', ID:'%s', BLOB:'%s'", index, id, base64);
+        =
msg(M_CLIENT, "%d", pkcs11_management_id_count());
+        msg(M_CLIENT, "=
END");
     }
     else
     {
-        msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d'=
", index);
+        msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_i=
d_count());
+    }
+}
+
+static void
+man_pkcs11_id_get(struct management *=
man, const char *p1, const char *p2)
+{
+    ASSERT(p1);
+
+    if ((streq(=
p1, "all") || p2 !=3D NULL) && man->connection=2Eclient_version < MCV_MULTI=
LINE_PKCS11_RESPONSE)
+    {
+        msg(M_CLIENT, "ERROR: Listing multipl=
e ids is only supported for version >=3D %d", MCV_MULTILINE_PKCS11_RESPONSE=
);
+        return;
     }
 
-    free(id);
-    free(base64);
+    if (man=
->connection=2Eclient_version >=3D MCV_MULTILINE_PKCS11_RESPONSE)
+    {
+ =
       unsigned int count =3D pkcs11_management_id_count();
+        unsign=
ed int from =3D (unsigned int)atoi(p1);
+        unsigned int to =3D p2 ? (=
unsigned int)atoi(p2) : from + 1;
+
+        if (streq(p1, "all"))
+       =
 {
+            from =3D 0;
+            to =3D count;
+        }
+
+      =
  bool error =3D false;
+        for (unsigned int i =3D from; i < min_uint=
(to, count) && !error; i++)
+        {
+            char *id =3D NULL;
+   =
         char *base64 =3D NULL;
+
+            if (pkcs11_management_id_get=
(i, &id, &base64))
+            {
+                msg(M_CLIENT, "%u,%s,%s"=
, i, id, base64);
+            }
+            else
+            {
+        =
        error =3D true;
+                msg(M_CLIENT, "ERROR: Failed to lo=
ad PKCS#11 id at index: %u", i);
+            }
+            free(id);
+   =
         free(base64);
+        }
+        if (!error)
+        {
+        =
    msg(M_CLIENT, "END");
+        }
+    }
+    else
+    {
+        int i=
ndex =3D atoi(p1);
+
+        char *id =3D NULL;
+        char *base64 =3D =
NULL;
+
+        if (pkcs11_management_id_get(index, &id, &base64))
+      =
  {
+            msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d', ID:'%s', BLOB:'%s'", =
index, id, base64);
+        }
+        else
+        {
+            msg(M_=
CLIENT, ">PKCS11ID-ENTRY:'%d'", index);
+        }
+        free(id);
+    =
    free(base64);
+    }
 }
 
 #endif /* ifdef ENABLE_PKCS11 */
@@ -1838,9 =
+1895,9 @@
     }
     else if (streq(p[0], "pkcs11-id-get"))
     {
-     =
   if (man_need(p, 1, 0))
+        if (man_need(p, 1, MN_AT_LEAST))
       =
  {
-            man_pkcs11_id_get(man, atoi(p[1]));
+            man_pkcs1=
1_id_get(man, p[1], p[2]);
         }
     }
 #endif
diff --git a/src/openv=
pn/manage=2Eh b/src/openvpn/manage=2Eh
index 82c0caa=2E=2E1d2aff1 100644
--=
- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -50,7 +50,7 @@
 =
#include "socket_util=2Eh"
 #include "mroute=2Eh"
 
-#define MANAGEMENT_VER=
SION                  6
+#define MANAGEMENT_VERSION                  7
 #de=
fine MANAGEMENT_N_PASSWORD_RETRIES       3
 #define MANAGEMENT_LOG_HISTORY_=
INITIAL_SIZE 100
 #define MANAGEMENT_ECHO_BUFFER_SIZE         100

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111=
a42128527d59832b8
Gerrit-Change-Number: 2148
Gerrit-PatchSet: 6
Gerrit-Owne=
r: opidopiopi@gmail=2Ecom
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: Gert Doering <gert@=
greenie=2Emuc=2Ede>
Gerrit-CC: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: opidopiopi@gmail=2Ecom
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention=
: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom>

--R/9BqvPe9K4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, Yuriy =
Darnobyt, opidopiopi@gmail=2Ecom=2E </p>
<p>opidopiopi@gmail=2Ecom <strong>=
uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">View Change</a></p><p>T=
he change is no longer submittable: checks~ChecksSubmitRule is unsatisfied =
now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Implement multiline responses for pkcs11-id command=
s<br><br>Responses to the management interface commands pkcs11-id-[get|coun=
t] did<br>not follow the standard syntax, but instead looked like notificat=
ions=2E<br><br>Introduce a new management interface version so that clients=
 announcing<br>versions &gt;=3D 7 will receive responses in the new format =
while keeping<br>compatibility for older client versions=2E<br><br>If a cli=
ent announces a management version &gt;=3D 7 the responses conform to<br>th=
e common multiline + END syntax=2E At the same time, it is now possible<br>=
to query all PKCS#11 ids using &quot;all&quot; or a range from &quot;start&=
quot; to<br>&quot;end&quot; - 1=2E Failures to retrieve an id will return a=
 partial response<br>terminated by an &quot;ERROR&quot; message including t=
he erroneous index=2E<br>The response format for pkcs11-id-get was changed =
to return a comma<br>separated list (index,id,cert_blob) which is easier to=
 parse=2E<br><br>Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8<br>Si=
gned-off-by: Marvin Wunderlich &lt;opidopiopi@gmail=2Ecom&gt;<br>---<br>M d=
oc/management-notes=2Etxt<br>M src/openvpn/manage=2Ec<br>M src/openvpn/mana=
ge=2Eh<br>3 files changed, 164 insertions(+), 21 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/48/2148/6</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/managem=
ent-notes=2Etxt</span><br><span>index 6c798c0=2E=2E42ea644 100644</span><br=
><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/managemen=
t-notes=2Etxt</span><br><span>@@ -617,23 +617,109 @@</span><br><span> COMMA=
ND -- pkcs11-id-count  (OpenVPN 2=2E1 or higher)</span><br><span> ---------=
------------------------------------------</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-Retrieve available number of certifi=
cates=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Retrieve av=
ailable number of PKCS#11 certificates=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+For management client versions &lt;7:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     pkcs11-id-count</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The reply is &qu=
ot;&gt;PKCS11ID-COUNT:&lt;count&gt;&quot;=2E</span><br><span> </span><br><s=
pan> Example:</span><br><span> </span><br><span>      pkcs11-id-count</span=
><br><span>      &gt;PKCS11ID-COUNT:5</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+For management client versions &gt;=3D =
7:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     pkcs11-id-count</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+The reply is a decimal count followed by &quot;END&quo=
t; on a separate line=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Example:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     pkcs11-id-count</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     5</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     END</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> COMMAND -- pkcs11-id-get  (OpenVPN 2=2E1 or hig=
her)</span><br><span> -------------------------------------------------</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Retri=
eve PKCS#11 certificates=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+For managem=
ent client versions &lt; 7:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id=
-get &lt;index&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> Retrieve certificate by index, the ID string should be pro=
vided</span><br><span> as PKCS#11 identity, the blob is a base 64 encoded c=
ertificate=2E</span><br><span> </span><br><span> Example:</span><br><span> =
</span><br><span>      pkcs11-id-get 1</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     PKCS11ID-ENTRY:&#39;1&#39;, ID:&#39;&lt;snip&gt;&#39;=
, BLOB:&#39;&lt;snip&gt;&#39;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     &gt;PKCS11ID-ENTRY:&#39;1&#39;, ID:&#39;&lt;id&gt;&#39;, BLO=
B:&#39;&lt;blob&gt;&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+For management=
 client versions &gt;=3D 7:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id=
-get &lt;index&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 pkcs11-id-get &lt;start&gt; &lt;end&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  pkcs11-id-get all</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+Retrieve a single PKCS#11 certificate at index &lt;index&gt; or multiple<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+PKCS#11 certificates=
 from index &lt;start&gt; to &lt;end&gt;-1=2E Alternatively</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+&lt;start&gt; =3D &quot;all&quot; r=
etrieves all PKCS#11 certificates=2E A comma separated</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+list including index, PKCS#11 id and the=
 base 64 encoded certificate</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+will be returned=2E If any id retrieval results in a failure, the =
returned</span><br><span style=3D"color: hsl(120, 100%, 40%);">+list will b=
e partial and terminated by &quot;ERROR: =2E=2E&quot; instead of &quot;END&=
quot;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The &quot;E=
RROR&quot; message will include the index of failure=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+Example 1:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Managemen=
t interface client sends:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id=
-get 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN daemon responds with:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    1,&lt;id&gt;,&lt;blob&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    END</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+Example 2:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Management =
interface client sends:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id-g=
et 1 3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN daemon responds with:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    1,&lt;id_a&gt;,&lt;blob_a&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    2,&lt;id_b&gt;,&lt;bl=
ob_b&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    END</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Example 3:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Management interface client sends:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    pkcs11-id-get all</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN dae=
mon with 3 PKCS#11 certificates responds with:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    0,&lt;id_a&gt;,&lt;blob_a&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    1,&lt;id_b&gt;,&lt;blob_b&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    2,&lt;id_c&gt;,&lt;blob_c&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    END</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+Example 4:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Managem=
ent interface client sends:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pkcs11-=
id-get all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN daemon with 3 PKCS=
#11 certificates fails to retrieve index 1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0,&lt;id_a&gt;,&lt;blob_a&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ERROR: Failed to load PKCS#11 id at index: 1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br=
><span> COMMAND -- client-auth  (OpenVPN 2=2E1 or higher)</span><br><span> =
-----------------------------------------------</span><br><span>@@ -1240,7 =
+1326,7 @@</span><br><span>     &quot;ERROR: [text]&quot;=2E</span><br><spa=
n> </span><br><span> (2) For commands which print multiple lines of output,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    the last line wil=
l be &quot;END&quot;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    the last line will be &quot;END&quot; or &quot;ERROR: [text]&quot;=
=2E</span><br><span> </span><br><span> (3) Real-time messages will be in th=
e form &quot;&gt;[source]:[text]&quot;,</span><br><span>     where source i=
s &quot;CLIENT&quot;, &quot;ECHO&quot;, &quot;FATAL&quot;, &quot;HOLD&quot;=
, &quot;INFO&quot;, &quot;LOG&quot;,</span><br><span>diff --git a/src/openv=
pn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 58f63e6=2E=2Ef=
00eb30 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>=
+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -74,6 +74,7 @@</span><br><s=
pan>     MCV_USERNAME_ONLY =3D 4,</span><br><span>     MCV_MULTILINE_PASSWO=
RD =3D 5,</span><br><span>     MCV_PREFERRED_USERNAME =3D 6,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    MCV_MULTILINE_PKCS11_RESPONSE =
=3D 7,</span><br><span> };</span><br><span> </span><br><span> struct manage=
ment *management; /* GLOBAL */</span><br><span>@@ -120,7 +121,8 @@</span><b=
r><span>     msg(M_CLIENT, &quot;pid                    : Show process ID o=
f the current OpenVPN process=2E&quot;);</span><br><span> #ifdef ENABLE_PKC=
S11</span><br><span>     msg(M_CLIENT, &quot;pkcs11-id-count        : Get n=
umber of available PKCS#11 identities=2E&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(M_CLIENT, &quot;pkcs11-id-get index    :=
 Get PKCS#11 identity at index=2E&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;pkcs11-id-get i|all [j] : Get=
 PKCS#11 identity at index =3D i=2E&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;                          F=
or version &gt;=3D 7 also i to j-1 or all=2E&quot;);</span><br><span> #endi=
f</span><br><span>     msg(M_CLIENT, &quot;client-auth CID KID    : Authent=
icate client-id/key-id CID/KID (MULTILINE)&quot;);</span><br><span>     msg=
(M_CLIENT, &quot;client-auth-nt CID KID : Authenticate client-id/key-id CID=
/KID&quot;);</span><br><span>@@ -894,26 +896,81 @@</span><br><span> static =
void</span><br><span> man_pkcs11_id_count(const struct management *man)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_count()=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-man_pkcs11_id_get(struct management *man, const int index)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    char *id =3D NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    char *base64 =3D NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (pkcs11_management_id_get(index, &amp;id, &amp;base64))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (man-&gt;connectio=
n=2Eclient_version &gt;=3D MCV_MULTILINE_PKCS11_RESPONSE)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_CL=
IENT, &quot;&gt;PKCS11ID-ENTRY:&#39;%d&#39;, ID:&#39;%s&#39;, BLOB:&#39;%s&=
#39;&quot;, index, id, base64);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_CLIENT, &quot;%d&quot;, pkcs11_management_id_coun=
t());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
CLIENT, &quot;END&quot;);</span><br><span>     }</span><br><span>     else<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(M_CLIENT, &quot;&gt;PKCS11ID-ENTRY:&#39;%d&#39;&quot;, index);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIEN=
T, &quot;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_count());</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_pkcs11=
_id_get(struct management *man, const char *p1, const char *p2)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(p1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if ((streq(p1, &quot;all&quot;) || p2 !=3D NULL) &amp;&amp; man-&gt;=
connection=2Eclient_version &lt; MCV_MULTILINE_PKCS11_RESPONSE)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: Listing mu=
ltiple ids is only supported for version &gt;=3D %d&quot;, MCV_MULTILINE_PK=
CS11_RESPONSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    free(id);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    free(base64);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (man-&gt;connection=2Eclient_version &gt;=3D M=
CV_MULTILINE_PKCS11_RESPONSE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    unsigned int count =3D pkcs11_management_id_count();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        unsigned int from =3D (unsigne=
d int)atoi(p1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    unsigned int to =3D p2 ? (unsigned int)atoi(p2) : from + 1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (streq(p1, &quot;all&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            from =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            to =3D count;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        bool error =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        for (unsigned int i =3D from; i &lt; min_=
uint(to, count) &amp;&amp; !error; i++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            char *id =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            char *base64 =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (pkcs11_management_id_get(i, &amp;id, &amp;=
base64))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
sg(M_CLIENT, &quot;%u,%s,%s&quot;, i, id, base64);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                error =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(M_CLIENT, &quot;ERROR: Fail=
ed to load PKCS#11 id at index: %u&quot;, i);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            free(id);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            free(base64);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!error)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_CLIENT, &quot;END&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ind=
ex =3D atoi(p1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *id =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *b=
ase64 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (pkcs11_mana=
gement_id_get(index, &amp;id, &amp;base64))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_CLIENT, &quot;&gt;PKCS11ID-ENTRY:&#39;%d&#3=
9;, ID:&#39;%s&#39;, BLOB:&#39;%s&#39;&quot;, index, id, base64);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;PKCS11ID-ENTRY:&#39;=
%d&#39;&quot;, index);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 free(id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
ree(base64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span> }</span><br><span> </span><br><span> #endif /* ifdef ENABLE=
_PKCS11 */</span><br><span>@@ -1838,9 +1895,9 @@</span><br><span>     }</sp=
an><br><span>     else if (streq(p[0], &quot;pkcs11-id-get&quot;))</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (man_need(p, 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            man_pkcs11_id=
_get(man, atoi(p[1]));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            man_pkcs11_id_get(man, p[1], p[2]);</span><br><span>        =
 }</span><br><span>     }</span><br><span> #endif</span><br><span>diff --gi=
t a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 8=
2c0caa=2E=2E1d2aff1 100644</span><br><span>--- a/src/openvpn/manage=2Eh</sp=
an><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -50,7 +50,7 @@=
</span><br><span> #include &quot;socket_util=2Eh&quot;</span><br><span> #in=
clude &quot;mroute=2Eh&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define MANAGEMENT_VERSION                  6</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MANAGEMENT_VERSI=
ON                  7</span><br><span> #define MANAGEMENT_N_PASSWORD_RETRIE=
S       3</span><br><span> #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100<=
/span><br><span> #define MANAGEMENT_ECHO_BUFFER_SIZE         100</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2148?usp=3Demail">change 2148</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2148?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2148 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: opidopiopi@gmail=2Ecom </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Selva Nair &lt;selva=2Enair@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: Yuriy Darnobyt &lt;yura=2Euddr@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: opidopiopi@gmail=2Ecom </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Yuriy Darnobyt &lt;yura=2Euddr@gmail=2Ecom&gt; </div>

</=
body></html>
--R/9BqvPe9K4=--


--===============4505829831644319515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4505829831644319515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4505829831644319515==--


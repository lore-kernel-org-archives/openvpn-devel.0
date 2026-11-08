Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2912606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C5wa8cSh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FsS4dTFD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lOgIAdqh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=f/ZG0j4C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dpEjj5w/bifYuRLpz/ksjqIvxgMHG/ctsRicOnNteVo=; b=C5wa8cShpKPOmobYFMAhsNPkL0
	90x18frkqOlNgknR0DZvPcDX6WByBCB+4awN2esuiu3iQFW/hSv8wQC9PhsCNNk71WBRPvPckWvlP
	s1ttV5g7TAG3RMDwkYioRmwSv6Sdaay20VzYAYnhPvZ/xRs4Z5HT9E7pUNjYOVbyRMhg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ0k2-000000006gP-2FUq;
	Sun, 08 Nov 2026 11:07:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ0jr-000000006gD-3FeE
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 11:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8rAZufxFLF0A6dKqWTWgo6cdBvKNYXN2YheZDQyVcwA=; b=FsS4dTFDpYf83UoPm8xsC8OMiF
 njZwEeqMpNTEL2uqbEozLwvx5xNYTA+Zw2pcJND0p7NOMM3DfmMLecyXdI0/9Nujyy5sRyLlGTSYX
 3pi2IMIBCrSMyrov7TQ9gZY6XrMTY4XAEtZASmd0u1qXqbNU/VAt0cy0RTj8A1mQ9ZU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8rAZufxFLF0A6dKqWTWgo6cdBvKNYXN2YheZDQyVcwA=; b=lOgIAdqhZ561M5N6TOhplwr9j0
 9lMlPJwJ/7igelvErADWAtaPLVUW5Y4WBVEMxLg6ViysiC0tSqYe45Tn+e23Un9WrvnetMiDIJzX4
 PUm7g11lI3CTFQu+K/dcgM0Vi50umsx5vuO+kddJmLVsuojRlj4ltFp7iZzs0U7ulZ08=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ0jp-0000000071G-2F4S for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 11:07:07 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-491971ac844so16517f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794136019; x=1794740819; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8rAZufxFLF0A6dKqWTWgo6cdBvKNYXN2YheZDQyVcwA=;
 b=f/ZG0j4CcJ/fyz8Swt+lePUj0qGqW1PWmrirDhHkaGF8siexinDI5xduh6hwED943m
 yyb9JdFsxrNY+JQ7Az9qtkjs+9cjFAD/vJuaRmwv8GwVDG1qTPFxyjNBNV7mOGL2333d
 WV8JJIpMt9E53/0aGDmtkllQqkKxEy4iKQT2JDMgBrmBwWW47UTqgoZijATKxuQuozxC
 m9BoBfNbhzpAgPcxslr3oE4n/tDNFZ+9Y+NpH1EzBpgSukv8Y0e4eeWDVE+mqYoyfs4V
 CVrJS9u/MTFAzEyF1K40tw6d+6ioG6YUdeKT9ZUp8GPT9wnxYHnKipcJAqi6chv6ZR6v
 OMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794136019; x=1794740819;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8rAZufxFLF0A6dKqWTWgo6cdBvKNYXN2YheZDQyVcwA=;
 b=SYFgwZ1ugnriOgIOKEVP33/dGIDehZp/++FksqheWcUX+j8+u4A/JvgXufOBxTfixO
 j7Acem+Fp78zsc1ZVc3aRLGEjxgW6GLeOrnp+z9U7ZiUSx/d3/YWEjye7ij9E0OGwNBA
 +TKOhTB2taSLrRx75fqUOqyPq3D4BgIz3xXp9N3jd1mwbiiQqePM7+y+Q7dZo2T8Bz2z
 Me/UqjbrodeG3L4iFfNKWjLVGLmPN22AW0Tb7+hANe/usNPlDxRMrj7a29rblpkUjr1n
 7f4nQk37CIX4WZChsih7iVeWqLp1cHMpZzCoegIISwuxU86vrtBzy3qbNsYIZWgcpmw/
 YDBw==
X-Gm-Message-State: APuU4Z9NEowFsexmvz15OjZdLYesc6hHFuSktyZUyN1Cj/LjWRMRhccV
 BXuawwPzsZiLm3cANjC4ywsd6Z2CDapXvuDWiHK4lYF5hyakEj8RcWVC8KXC/RXyVea7lwerCxW
 Hr+mT7OkycbiVSJTLGmUDFuHiUVHUVq8Eg3YdmDDamQdPP81LHx/tFQmUgLiEdu0CjC+A
X-Gm-Gg: AYBFou21+NpWJfHljoDg4weVYIEher1s8B2v1ZLmbusykgkGvhqDspmgls+H+YpSVN9
 nFuctY4gTDcXyJB8UuwAOM/lkKMuGSA0PdqOgi3wjZRPtMMpU2LwtqaVOrANQagLKp8Ab4cYiIr
 dl/sjD1E38rJftbpoPgyremKgZLKbnaHQ2MsqJFSr3QiN4dzlNGbVcX+ZF3DjkJb4wzloLCiPyB
 fcEiQ+FvW9haSiyfCrmpNDQfc++AHuCiN73/AkJJhS8gB6s2WZyxKltu02MgHlbIh4qJshWGWyC
 VgkasWDFCia7PPcsSczSFY455wUvfe0PbEn8Ydmr+EY6De+ueA1xvf+mXKcYBaPMODMlrrJc+sx
 03QxEkQWhxl22gnQ6TeIayUEIGZ3Ku/rzUvrWRdf4JzS/vfnNW22ivM2TNyiOlsMoxQl4Ne8zBD
 Wg6dPzzyO0N2dwENhIJnImHDIq1jSoVjA0ENDkxzCUgUa80In7eip7pX28+Otf45YR1UgSHnBa8
 8dnk+K1u7u3IXK3iP2dx/6SGv4QPrQXKN0xNze4DUYkaPFS7PsLP6ReVzeAXukM8PLO8594VtfJ
 E/lhNZ9RpWOco/02TnaPc2PJh8TcjDMHvEajz2mkm3jKFKAkcgQl9el5in6D/19QRkOG7DurEFH
 iA6L3VLFXQUcStCo0mzGcCUrgGnXdU6/6IDztGpKPb4iX//s36Qe9v8We4nsMTz3Tqyy5dGjbiV
 LCJg0XS7nRVyZa2g==
X-Received: by 2002:adf:e18a:0:b0:491:b5ad:8e57 with SMTP id
 ffacd0b85a97d-49583ee21f8mr2476976f8f.15.1794136018639; 
 Sun, 08 Nov 2026 03:06:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597748acbsm3386724f8f.44.2026.11.08.03.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 03:06:58 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 11:06:56 +0000
To: Selva Nair <selva.nair@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 2f0d22492f7753b0d6295f015471313e7f03e959
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b8548e9fc96cd13ad5cb278bad45d9451c53eb8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ0jp-0000000071G-2F4S
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
 openvpn-devel@lists.sourceforge.net
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0325290231935000095=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0325290231935000095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s4JtP1ZG1yA="; charset=UTF-8

--s4JtP1ZG1yA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Selva Nair, opidopiopi@=
gmail=2Ecom=2E

Hello Arne Schwabe, Selva Nair, 

I'd like you to reexamine=
 a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
148?usp=3Demail

to look at the new patch set (#2)=2E

The following approv=
als got outdated and were removed:
Code-Review-1 by Selva Nair


Change sub=
ject: Implement multiline responses for pkcs11-id commands
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement multiline response=
s for pkcs11-id commands

Responses to the management interface commands pk=
cs11-id-[get|count] did
not follow the standard syntax, but instead looked =
like notifications=2E

Introduce a new management interface version to rewr=
ite both commands to
conform to the common multiline + END syntax=2E At the=
 same time it is now
possible to query all PKCS#11 ids using "all" or a ran=
ge from "start" to
"end" - 1=2E Failures to retrieve an id will return a pa=
rtial response
terminated by an "ERROR" message including the erroneous ind=
ex=2E

The response format was changed to comma separated (index,id,cert_bl=
ob)
which is easier to parse=2E

Change-Id: I09e55085cde6dbc0040e111a421285=
27d59832b8
Signed-off-by: Marvin Wunderlich <opdopiopi@gmail=2Ecom>
---
M d=
oc/management-notes=2Etxt
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh=

3 files changed, 164 insertions(+), 21 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/2148/2

diff --git a/doc/=
management-notes=2Etxt b/doc/management-notes=2Etxt
index 6c798c0=2E=2E42ea=
644 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etx=
t
@@ -617,23 +617,109 @@
 COMMAND -- pkcs11-id-count  (OpenVPN 2=2E1 or hig=
her)
 ---------------------------------------------------
 
-Retrieve avail=
able number of certificates=2E
+Retrieve available number of PKCS#11 certif=
icates=2E
+
+For management client versions <7:
+
+     pkcs11-id-count
+
+=
The reply is ">PKCS11ID-COUNT:<count>"=2E
 
 Example:
 
      pkcs11-id-cou=
nt
      >PKCS11ID-COUNT:5
 
+For management client versions >=3D 7:
+
+   =
  pkcs11-id-count
+
+The reply is a decimal count followed by "END" on a se=
parate line=2E
+
+Example:
+
+     pkcs11-id-count
+     5
+     END
+
 COM=
MAND -- pkcs11-id-get  (OpenVPN 2=2E1 or higher)
 -------------------------=
------------------------
 
+Retrieve PKCS#11 certificates=2E
+
+For managem=
ent client versions < 7:
+
+  pkcs11-id-get <index>
+
 Retrieve certificate=
 by index, the ID string should be provided
 as PKCS#11 identity, the blob =
is a base 64 encoded certificate=2E
 
 Example:
 
      pkcs11-id-get 1
-  =
   PKCS11ID-ENTRY:'1', ID:'<snip>', BLOB:'<snip>'
+     >PKCS11ID-ENTRY:'1'=
, ID:'<id>', BLOB:'<blob>'
+
+For management client versions >=3D 7:
+
+  p=
kcs11-id-get <index>
+  pkcs11-id-get <start> <end>
+  pkcs11-id-get all
+
=
+Retrieve a single PKCS#11 certificate at index <index> or multiple
+PKCS#1=
1 certificates from index <start> to <end>-1=2E Alternatively
+<start> =3D =
"all" retrieves all PKCS#11 certificates=2E A comma separated
+list includi=
ng index, PKCS#11 id and the base 64 encoded certificate
+will be returned=
=2E If any id retrieval results in a failure, the returned
+list will be pa=
rtial and terminated by "ERROR: =2E=2E" instead of "END"=2E
+The "ERROR" me=
ssage will include the index of failure=2E
+
+Example 1:
+
+  Management in=
terface client sends:
+
+    pkcs11-id-get 1
+
+  OpenVPN daemon responds w=
ith:
+
+    1,<id>,<blob>
+    END
+
+Example 2:
+
+  Management interface =
client sends:
+
+    pkcs11-id-get 1 3
+
+  OpenVPN daemon responds with:
+=

+    1,<id_a>,<blob_a>
+    2,<id_b>,<blob_b>
+    END
+
+Example 3:
+
+  =
Management interface client sends:
+
+    pkcs11-id-get all
+
+  OpenVPN da=
emon with 3 PKCS#11 certificates responds with:
+
+    0,<id_a>,<blob_a>
+ =
   1,<id_b>,<blob_b>
+    2,<id_c>,<blob_c>
+    END
+
+Example 4:
+
+  Man=
agement interface client sends:
+
+    pkcs11-id-get all
+
+  OpenVPN daemo=
n with 3 PKCS#11 certificates fails to retrieve index 1
+
+    0,<id_a>,<bl=
ob_a>
+    ERROR: Failed to load PKCS#11 id at index: 1
+
 
 COMMAND -- cli=
ent-auth  (OpenVPN 2=2E1 or higher)
 --------------------------------------=
---------
@@ -1240,7 +1326,7 @@
     "ERROR: [text]"=2E
 
 (2) For commands=
 which print multiple lines of output,
-    the last line will be "END"=2E
=
+    the last line will be "END" or "ERROR: [text]"=2E
 
 (3) Real-time mes=
sages will be in the form ">[source]:[text]",
     where source is "CLIENT"=
, "ECHO", "FATAL", "HOLD", "INFO", "LOG",
diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec
index 58f63e6=2E=2Ef00eb30 100644
--- a/src/o=
penvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -74,6 +74,7 @@
     MCV_U=
SERNAME_ONLY =3D 4,
     MCV_MULTILINE_PASSWORD =3D 5,
     MCV_PREFERRED_U=
SERNAME =3D 6,
+    MCV_MULTILINE_PKCS11_RESPONSE =3D 7,
 };
 
 struct mana=
gement *management; /* GLOBAL */
@@ -120,7 +121,8 @@
     msg(M_CLIENT, "pi=
d                    : Show process ID of the current OpenVPN process=2E");=

 #ifdef ENABLE_PKCS11
     msg(M_CLIENT, "pkcs11-id-count        : Get num=
ber of available PKCS#11 identities=2E");
-    msg(M_CLIENT, "pkcs11-id-get=
 index    : Get PKCS#11 identity at index=2E");
+    msg(M_CLIENT, "pkcs11-=
id-get i|all [j] : Get PKCS#11 identity at index =3D i=2E");
+    msg(M_CLI=
ENT, "                          For version >=3D 7 also i to j-1 or all=2E"=
);
 #endif
     msg(M_CLIENT, "client-auth CID KID    : Authenticate client=
-id/key-id CID/KID (MULTILINE)");
     msg(M_CLIENT, "client-auth-nt CID KI=
D : Authenticate client-id/key-id CID/KID");
@@ -894,26 +896,81 @@
 static =
void
 man_pkcs11_id_count(const struct management *man)
 {
-    msg(M_CLIEN=
T, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count());
-}
-
-static void
-=
man_pkcs11_id_get(struct management *man, const int index)
-{
-    char *id=
 =3D NULL;
-    char *base64 =3D NULL;
-
-    if (pkcs11_management_id_get(=
index, &id, &base64))
+    if (man->connection=2Eclient_version >=3D MCV_MU=
LTILINE_PKCS11_RESPONSE)
     {
-        msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d=
', ID:'%s', BLOB:'%s'", index, id, base64);
+        msg(M_CLIENT, "%d", pk=
cs11_management_id_count());
+        msg(M_CLIENT, "END");
     }
     els=
e
     {
-        msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d'", index);
+        ms=
g(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count());
+    }
+}
=
+
+static void
+man_pkcs11_id_get(struct management *man, const char *p1, c=
onst char *p2)
+{
+    ASSERT(p1);
+
+    if ((streq(p1, "all") || p2 !=3D =
NULL) && man->connection=2Eclient_version < MCV_MULTILINE_PKCS11_RESPONSE)
=
+    {
+        msg(M_CLIENT, "ERROR: Listing multiple ids is only supporte=
d for version >=3D %d", MCV_MULTILINE_PKCS11_RESPONSE);
+        return;
  =
   }
 
-    free(id);
-    free(base64);
+    if (man->connection=2Eclient_=
version >=3D MCV_MULTILINE_PKCS11_RESPONSE)
+    {
+        unsigned int co=
unt =3D pkcs11_management_id_count();
+        unsigned int from =3D (unsig=
ned int)atoi(p1);
+        unsigned int to =3D p2 ? (unsigned int)atoi(p2) =
: from + 1;
+
+        if (streq(p1, "all"))
+        {
+            from =
=3D 0;
+            to =3D count;
+        }
+
+        bool error =3D fals=
e;
+        for (unsigned int i =3D from; i < min_uint(to, count) && !error=
; i++)
+        {
+            char *id =3D NULL;
+            char *base64=
 =3D NULL;
+
+            if (pkcs11_management_id_get(i, &id, &base64))
+ =
           {
+                msg(M_CLIENT, "%u,%s,%s", i, id, base64);
+  =
          }
+            else
+            {
+                error =3D tru=
e;
+                msg(M_CLIENT, "ERROR: Failed to load PKCS#11 id at inde=
x: %u", i);
+            }
+            free(id);
+            free(base64)=
;
+        }
+        if (!error)
+        {
+            msg(M_CLIENT, "EN=
D");
+        }
+    }
+    else
+    {
+        int index =3D atoi(p1);
+
=
+        char *id =3D NULL;
+        char *base64 =3D NULL;
+
+        if (=
pkcs11_management_id_get(index, &id, &base64))
+        {
+            msg(=
M_CLIENT, ">PKCS11ID-ENTRY:'%d', ID:'%s', BLOB:'%s'", index, id, base64);
+=
        }
+        else
+        {
+            msg(M_CLIENT, ">PKCS11ID-EN=
TRY:'%d'", index);
+        }
+        free(id);
+        free(base64);
+  =
  }
 }
 
 #endif /* ifdef ENABLE_PKCS11 */
@@ -1838,9 +1895,9 @@
     }
   =
  else if (streq(p[0], "pkcs11-id-get"))
     {
-        if (man_need(p, 1,=
 0))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
-            man_=
pkcs11_id_get(man, atoi(p[1]));
+            man_pkcs11_id_get(man, p[1], p=
[2]);
         }
     }
 #endif
diff --git a/src/openvpn/manage=2Eh b/src/o=
penvpn/manage=2Eh
index 82c0caa=2E=2E1d2aff1 100644
--- a/src/openvpn/manag=
e=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -50,7 +50,7 @@
 #include "socket_util=
=2Eh"
 #include "mroute=2Eh"
 
-#define MANAGEMENT_VERSION                 =
 6
+#define MANAGEMENT_VERSION                  7
 #define MANAGEMENT_N_PAS=
SWORD_RETRIES       3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100
 #de=
fine MANAGEMENT_ECHO_BUFFER_SIZE         100

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
Ge=
rrit-Change-Number: 2148
Gerrit-PatchSet: 2
Gerrit-Owner: opidopiopi@gmail=
=2Ecom
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Selva Nair <selva=
=2Enair@gmail=2Ecom>
Gerrit-Attention: opidopiopi@gmail=2Ecom
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--s4JtP1ZG1yA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Selva Nair, opidopiopi@gmail=2Ecom=2E <=
/p>
<p>opidopiopi@gmail=2Ecom <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/214=
8?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by Selva Nair</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">Implement mul=
tiline responses for pkcs11-id commands<br><br>Responses to the management =
interface commands pkcs11-id-[get|count] did<br>not follow the standard syn=
tax, but instead looked like notifications=2E<br><br>Introduce a new manage=
ment interface version to rewrite both commands to<br>conform to the common=
 multiline + END syntax=2E At the same time it is now<br>possible to query =
all PKCS#11 ids using &quot;all&quot; or a range from &quot;start&quot; to<=
br>&quot;end&quot; - 1=2E Failures to retrieve an id will return a partial =
response<br>terminated by an &quot;ERROR&quot; message including the errone=
ous index=2E<br><br>The response format was changed to comma separated (ind=
ex,id,cert_blob)<br>which is easier to parse=2E<br><br>Change-Id: I09e55085=
cde6dbc0040e111a42128527d59832b8<br>Signed-off-by: Marvin Wunderlich &lt;op=
dopiopi@gmail=2Ecom&gt;<br>---<br>M doc/management-notes=2Etxt<br>M src/ope=
nvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>3 files changed, 164 inserti=
ons(+), 21 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/48/2148/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc=
/management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index =
6c798c0=2E=2E42ea644 100644</span><br><span>--- a/doc/management-notes=2Etx=
t</span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -617,=
23 +617,109 @@</span><br><span> COMMAND -- pkcs11-id-count  (OpenVPN 2=2E1 =
or higher)</span><br><span> -----------------------------------------------=
----</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-Retrieve available number of certificates=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+Retrieve available number of PKCS#11 certificates=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+For management client versions &lt;=
7:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     pkcs11-id-count</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+The reply is &quot;&gt;PKCS11ID-COUNT:&lt;count&gt;&qu=
ot;=2E</span><br><span> </span><br><span> Example:</span><br><span> </span>=
<br><span>      pkcs11-id-count</span><br><span>      &gt;PKCS11ID-COUNT:5<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Fo=
r management client versions &gt;=3D 7:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     pkcs11-id-count</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The reply is a de=
cimal count followed by &quot;END&quot; on a separate line=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+Example:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     pk=
cs11-id-count</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     5=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     END</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- p=
kcs11-id-get  (OpenVPN 2=2E1 or higher)</span><br><span> ------------------=
-------------------------------</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+Retrieve PKCS#11 certificates=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+For management client versions &lt; 7:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  pkcs11-id-get &lt;index&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Retrieve certificate by=
 index, the ID string should be provided</span><br><span> as PKCS#11 identi=
ty, the blob is a base 64 encoded certificate=2E</span><br><span> </span><b=
r><span> Example:</span><br><span> </span><br><span>      pkcs11-id-get 1</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     PKCS11ID-ENTRY:&#3=
9;1&#39;, ID:&#39;&lt;snip&gt;&#39;, BLOB:&#39;&lt;snip&gt;&#39;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     &gt;PKCS11ID-ENTRY:&#39;1=
&#39;, ID:&#39;&lt;id&gt;&#39;, BLOB:&#39;&lt;blob&gt;&#39;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+For management client versions &gt;=3D 7:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  pkcs11-id-get &lt;index&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id-get &lt;start&gt; &lt;end&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id-get all=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+Retrieve a single PKCS#11 certificate =
at index &lt;index&gt; or multiple</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+PKCS#11 certificates from index &lt;start&gt; to &lt;end&gt;=
-1=2E Alternatively</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
&lt;start&gt; =3D &quot;all&quot; retrieves all PKCS#11 certificates=2E A c=
omma separated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+list =
including index, PKCS#11 id and the base 64 encoded certificate</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+will be returned=2E If any id r=
etrieval results in a failure, the returned</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+list will be partial and terminated by &quot;ERROR:=
 =2E=2E&quot; instead of &quot;END&quot;=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+The &quot;ERROR&quot; message will include the inde=
x of failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 1:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  Management interface client sends:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    pkcs11-id-get 1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  OpenVPN daemon responds with:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
1,&lt;id&gt;,&lt;blob&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 2:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  Management interface client sends:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    pkcs11-id-get 1 3</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  OpenVPN daemon responds with:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
1,&lt;id_a&gt;,&lt;blob_a&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    2,&lt;id_b&gt;,&lt;blob_b&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    END</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Example=
 3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Management interface client sends=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id-get all</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  OpenVPN daemon with 3 PKCS#11 certificates responds =
with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    0,&lt;id_a&gt;,&lt;blob_a&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    1,&lt;id_b&gt;,=
&lt;blob_b&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    2=
,&lt;id_c&gt;,&lt;blob_c&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 4:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  Management interface client sends:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    pkcs11-id-get all</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  OpenVPN daemon with 3 PKCS#11 certificates fails to retrieve index =
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    0,&lt;id_a&gt;,&lt;blob_a&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ERROR: Failed to lo=
ad PKCS#11 id at index: 1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> </span><br><span> COMMAND -- client-auth  (OpenVPN =
2=2E1 or higher)</span><br><span> -----------------------------------------=
------</span><br><span>@@ -1240,7 +1326,7 @@</span><br><span>     &quot;ERR=
OR: [text]&quot;=2E</span><br><span> </span><br><span> (2) For commands whi=
ch print multiple lines of output,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    the last line will be &quot;END&quot;=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    the last line will be &quot;END&q=
uot; or &quot;ERROR: [text]&quot;=2E</span><br><span> </span><br><span> (3)=
 Real-time messages will be in the form &quot;&gt;[source]:[text]&quot;,</s=
pan><br><span>     where source is &quot;CLIENT&quot;, &quot;ECHO&quot;, &q=
uot;FATAL&quot;, &quot;HOLD&quot;, &quot;INFO&quot;, &quot;LOG&quot;,</span=
><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</sp=
an><br><span>index 58f63e6=2E=2Ef00eb30 100644</span><br><span>--- a/src/op=
envpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><sp=
an>@@ -74,6 +74,7 @@</span><br><span>     MCV_USERNAME_ONLY =3D 4,</span><b=
r><span>     MCV_MULTILINE_PASSWORD =3D 5,</span><br><span>     MCV_PREFERR=
ED_USERNAME =3D 6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   MCV_MULTILINE_PKCS11_RESPONSE =3D 7,</span><br><span> };</span><br><span=
> </span><br><span> struct management *management; /* GLOBAL */</span><br><=
span>@@ -120,7 +121,8 @@</span><br><span>     msg(M_CLIENT, &quot;pid      =
              : Show process ID of the current OpenVPN process=2E&quot;);</=
span><br><span> #ifdef ENABLE_PKCS11</span><br><span>     msg(M_CLIENT, &qu=
ot;pkcs11-id-count        : Get number of available PKCS#11 identities=2E&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_CLIEN=
T, &quot;pkcs11-id-get index    : Get PKCS#11 identity at index=2E&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &q=
uot;pkcs11-id-get i|all [j] : Get PKCS#11 identity at index =3D i=2E&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, =
&quot;                          For version &gt;=3D 7 also i to j-1 or all=
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
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=
=2Ecom </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Selva N=
air &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: opidopiopi@gmail=2Ecom </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

<=
/body></html>
--s4JtP1ZG1yA=--


--===============0325290231935000095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0325290231935000095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0325290231935000095==--


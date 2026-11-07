Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBC606A336
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IcQBbLjQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j0j1i3q7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QYxeUF7X;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NB4oOyrh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=KBCXUQRMl/a+7sSrkHsQCi+h3wrkDK1IvGGWZGAn2Bg=; b=IcQBbLjQXqU1wTmwbdKRioQ4F4
	iHBmoh6haUkZHN8W/Vt9ZpZxf/jullaBlXDBFcCYroz8oDY4ZJIIBw++afePEmsoTiYkoFvCgYya/
	tTqtRO08BVxH8Hbnb0w7qISNvYAKe5F1/o5illTwtfqYpMSr8ZMH3NuPmxSs9BeX4kxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPgok-000000005W4-1Luk;
	Sat, 07 Nov 2026 13:50:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPgoi-000000005Vx-3Uoq
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 13:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z6xzw7xOa4yQQiLqspJuCuUOzvimqUUYbuOB33+Zxro=; b=j0j1i3q7/464UUwQ3tbqTNPpOM
 UZgohP4brm3jjo2JBtnueLd1d+6DR8LGIOm9Wlaz7juKCzzPF97yVHhE4Qq3TncUUVR2C17nLhauf
 Wlato5bDuPoHp3dgSyxcDEQOBS7dNwpH+5QwUjnq7sEzir58MPMQ6wI7xV6QLQLaq06Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z6xzw7xOa4yQQiLqspJuCuUOzvimqUUYbuOB33+Zxro=; b=QYxeUF7XBfIOp1t+rZq0KRmSaw
 wi78/7PFwCGdAnpLwz5atS9KKgMX/6B0H0KR0pO5B8KR1k2fBLTTP8xG3RRdkPosGgrnkrt4zvur9
 tg/SC8q1WkkO1O8/2JDVGWYxGwhS6/0UvnjbxH6mF6UcXW1kojGpWHn7YjIJxCuaJMVU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPgoh-000000006Sy-1KY1 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 13:50:48 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so11992075e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794059441; x=1794664241; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z6xzw7xOa4yQQiLqspJuCuUOzvimqUUYbuOB33+Zxro=;
 b=NB4oOyrhSUkJ0AwX1nw78JFZDRhIfluN1Rnumvdkic5ULBp+vYOHJnjHh3GD1JFppb
 Uc9XAqyV8WROrZQ/3nju1p30Z0ebxQhV58XGjs4IROaZoDm4yozCmNtfapBz+0xp1I4P
 exT4uh8+AGvtsqYGGf/64cLVMXKq3RwxR5Gb9Z7sQu8IS5fybPJj0e/NGfQ9Fj9fzvrh
 lKRp60Y9BkHyGGe1KJdhyfRajyOoRMbAIxwwnNmeS7LAyImTgkmcaR9NH6rnBFjLQU5x
 nhTgwtu5T2j79lSmBgiloJEObL1Nf9+fNth1Qot+E9apnrPMkvIkJmqX9A8k8fvCwG3n
 QL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794059441; x=1794664241;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z6xzw7xOa4yQQiLqspJuCuUOzvimqUUYbuOB33+Zxro=;
 b=Oj5jzSTG1RhXzHc7RcAc/qCyY42utePR1gUoPiOwOaCQvvC1hvzIZAM13Z0vyllHQd
 NOuKJWjaFzTnrjnR7jsK0Qnf4KPETuMd3Ie8WVKYR1F24Jd6cp6GsWCBsy3ey/irsGIs
 t9KHznDXJZGEwO18S6J0bvK6Y7mVmZVh6AAyXjTrPzbpxAiIJDa4O/n6sTCtSPQ+mSue
 5g2S4j65gb+9rQ/RvYAQ7gqldkSYb4LmmDr9t1HU+H/rtRjgbveDBLO7Q0eGWdWO1Hf5
 hqfWbKCFDt/tGFF65AOEqBB5kHevy1OvG86KZkGx9mE1SbY/B9G9eYB3viEbSxL0ibjp
 9Xyg==
X-Gm-Message-State: APuU4Z/G+rosx0oWQjfmoSuN8ibMmarWNBt97MNi3lInRLuFux1fE46r
 18UY8wRPwUJow/ENdsvVAOLp3EyPRbDd8lX2FIpBxdAi3NzcDkyGvyKdW+BqM4T9rHfWRAi/whn
 Srhyw4RAWqz0WasgoqBt0zNN2TqogjUAVNqHef7MFUG84KK12Ykp9MCQvgDzObbyTnhdhEpCO+I
 tNWeOJGg==
X-Gm-Gg: AYBFou0lJf9OjPVxTb2fB1sqYDsLl3Xg9VYNbBrrNaNQwr6fmHhecChofM9kNWG6tnN
 8q5KB3+Iv1h1pns9Re9vc4WWlSWSHM2/vZMuM2+PbrTk+ldG8qJdF33pjOoMuKQEuQ0JBB2a5fA
 I87lpcXEvujSIDIJ53OSGqFi24X/VABuKeX6aWcfbxifUB6t69eZ5LkpdTDpJRsZmGY3SwIFhVn
 ViY0MKuF7QR4M7Lhc/OsKbSqBECAyzll+0KNJV+to507lzM2DjsXqFSBLnfAqckw9ctVmN/ogcJ
 R8S+MeHjHahj3HBmM+PNgzxhUxaR2V6AnqSvbedlscjjsRrp37eRRrYF5bMwENIRbqUqixvpalq
 0tVaknQp0OBqtfh9K3NoyrEb2JiGfbpDj40jXc3VygYm0imWPyZfLLEPOCxlDgUiXFhCnpzluza
 CG3ohUth/9nq2abQ7qhGoDIy8iAQSiX03xhBwe19W6/C5mggbSA1sCJ0m9xKl7B2e7PNqNrOm/S
 Oflxst/1l0N8sKs5NUqmzKQIm1kB4O5Q4soTiwoXZBNoXYOA91oiCo5HGTUsupOM92lgNnU6g4+
 u5vI2IpVDIm+RcSIdAk6dkqTkQJnInuvP/gnfJBaUTsg/SF7XvpkYx0wI9WOaujQOavAcrFo1JO
 sTd+3ILYCebx5DlRErCdj2Ifb4oJLVj6UuOFQqhgI52+fRWHPJ6vB3C4qzP+lV7uH0jLMjdbc78
 OVPK8osKhjW18OrQ==
X-Received: by 2002:a05:600c:4eca:b0:4a8:b8b4:6226 with SMTP id
 5b1f17b1804b1-4b6dfba9e37mr99768965e9.28.1794059440429; 
 Sat, 07 Nov 2026 05:50:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbdb9cdsm65771285e9.1.2026.11.07.05.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 05:50:40 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 13:50:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 589b59dd314e72affe07497b2172199f194e3347
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eec0d98f287024ee1f732c9746f053f6d7b2bb19-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPgoh-000000006Sy-1KY1
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6295144442597714129=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6295144442597714129==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bOK+1JpZS7I="; charset=UTF-8

--bOK+1JpZS7I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2148?usp=3Demail

to review the following change=2E
=


Change subject: Implement multiline responses for pkcs11-id commands
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement multil=
ine responses for pkcs11-id commands

Responses to the management interface=
 commands pkcs11-id-[get|count] did
not follow the standard syntax, but ins=
tead looked like notifications=2E

Introduce a new management interface ver=
sion to rewrite both commands to
conform to the common multiline + END synt=
ax=2E At the same time it is now
possible to query all PKCS#11 ids using "a=
ll" or a range from "start" to
"end" - 1=2E Failures to retrieve an id will=
 return a partial response
terminated by an "ERROR" message including the e=
rroneous index=2E

The response format was changed to comma separated (inde=
x,id,cert_blob)
which is easier to parse=2E

Change-Id: I09e55085cde6dbc004=
0e111a42128527d59832b8
Signed-off-by: Marvin Wunderlich <opdopiopi@gmail=2E=
com>
---
M doc/management-notes=2Etxt
M src/openvpn/manage=2Ec
M src/openvp=
n/manage=2Eh
3 files changed, 167 insertions(+), 30 deletions(-)



  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/2148/1

diff=
 --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 6c79=
8c0=2E=2E299cd29 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/manageme=
nt-notes=2Etxt
@@ -619,21 +619,89 @@
 
 Retrieve available number of certif=
icates=2E
 
-Example:
+Example for client version < 7:
 
      pkcs11-id-co=
unt
      >PKCS11ID-COUNT:5
 
+Example for client version >=3D 7:
+
+     p=
kcs11-id-count
+     5
+     END
+
 COMMAND -- pkcs11-id-get  (OpenVPN 2=2E=
1 or higher)
 -------------------------------------------------
 
+  pkcs11=
-id-get <index>
+
 Retrieve certificate by index, the ID string should be p=
rovided
 as PKCS#11 identity, the blob is a base 64 encoded certificate=2E
=
 
-Example:
+Example for client version < 7:
 
      pkcs11-id-get 1
-     =
PKCS11ID-ENTRY:'1', ID:'<snip>', BLOB:'<snip>'
+     >PKCS11ID-ENTRY:'1', I=
D:'<snip>', BLOB:'<snip>'
+
+For client versions >=3D 7 it is also possible=
 to retrieve multiple
+PKCS#11 identities from index <start> to <end>-1=2E =
Alternatively
+<start> =3D "all" retrieves all PKCS#11 identities=2E A comm=
a separated
+list including index, PKCS#11 id and the base 64 encoded certi=
ficate
+will be returned=2E If any id retrieval results in a failure, the r=
eturned
+list will be partial and terminated by "ERROR: =2E=2E" instead of =
"END"=2E
+The "ERROR" message will include the index of failure=2E
+
+  pkc=
s11-id-get <index>
+  pkcs11-id-get <start> <end>
+  pkcs11-id-get all
+
+E=
xample 1:
+
+  Management interface client sends:
+
+    pkcs11-id-get 1
+
=
+  OpenVPN daemon responds with:
+
+    1,<id>,<blob>
+    END
+
+Example 2=
:
+
+  Management interface client sends:
+
+    pkcs11-id-get 1 3
+
+  Ope=
nVPN daemon responds with:
+
+    1,<id_a>,<blob_a>
+    2,<id_b>,<blob_b>
=
+    END
+
+Example 3:
+
+  Management interface client sends:
+
+    pkcs1=
1-id-get all
+
+  OpenVPN daemon with 3 PKCS#11 identities responds with:
+=

+    0,<id_a>,<blob_a>
+    1,<id_b>,<blob_b>
+    2,<id_c>,<blob_c>
+    =
END
+
+Example 4:
+
+  Management interface client sends:
+
+    pkcs11-id-=
get all
+
+  OpenVPN daemon with 3 PKCS#11 identities fails to retrieve ind=
ex 1
+
+    0,<id_a>,<blob_a>
+    ERROR: Failed to load PKCS#11 id at inde=
x: 1
+
 
 COMMAND -- client-auth  (OpenVPN 2=2E1 or higher)
 --------------=
---------------------------------
diff --git a/src/openvpn/manage=2Ec b/src=
/openvpn/manage=2Ec
index 58f63e6=2E=2Ef33e881 100644
--- a/src/openvpn/man=
age=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -74,6 +74,7 @@
     MCV_USERNAME_ON=
LY =3D 4,
     MCV_MULTILINE_PASSWORD =3D 5,
     MCV_PREFERRED_USERNAME =
=3D 6,
+    MCV_MULTILINE_PKCS11_RESPONSE =3D 7,
 };
 
 struct management *=
management; /* GLOBAL */
@@ -120,7 +121,8 @@
     msg(M_CLIENT, "pid       =
             : Show process ID of the current OpenVPN process=2E");
 #ifdef=
 ENABLE_PKCS11
     msg(M_CLIENT, "pkcs11-id-count        : Get number of a=
vailable PKCS#11 identities=2E");
-    msg(M_CLIENT, "pkcs11-id-get index  =
  : Get PKCS#11 identity at index=2E");
+    msg(M_CLIENT, "pkcs11-id-get i=
|all [j] : Get PKCS#11 identity at index =3D i=2E");
+    msg(M_CLIENT, "  =
                        For version >=3D 7 also i to j-1 or all=2E");
 #end=
if
     msg(M_CLIENT, "client-auth CID KID    : Authenticate client-id/key-=
id CID/KID (MULTILINE)");
     msg(M_CLIENT, "client-auth-nt CID KID : Auth=
enticate client-id/key-id CID/KID");
@@ -889,31 +891,104 @@
         man_co=
mmand_unsupported("cr-repsonse");
     }
 }
+
+static unsigned int
+parse_r=
ange_start(const char *p1)
+{
+    if (streq(p1, "all"))
+    {
+        re=
turn 0;
+    }
+    return (unsigned int)atoi(p1);
+}
+
+static unsigned in=
t
+parse_range_end(const char *p1, const char *p2, unsigned int max)
+{
+  =
  unsigned int from =3D (unsigned int)atoi(p1);
+    unsigned int to =3D p2=
 ? (unsigned int)atoi(p2) : from + 1;
+
+    if (streq(p1, "all"))
+    {
+=
        to =3D max;
+    }
+
+    return min_uint(to, max);
+}
+
 #ifdef EN=
ABLE_PKCS11
 
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
       unsigned int from =3D parse_range_start(p1);
+        unsigned int t=
o =3D parse_range_end(p1, p2, pkcs11_management_id_count());
+
+        boo=
l error =3D false;
+        for (unsigned int i =3D from; i < to && !error;=
 i++)
+        {
+            char *id =3D NULL;
+            char *base64 =
=3D NULL;
+
+            if (pkcs11_management_id_get(i, &id, &base64))
+  =
          {
+                msg(M_CLIENT, "%u,%s,%s", i, id, base64);
+   =
         }
+            else
+            {
+                error =3D true=
;
+                msg(M_CLIENT, "ERROR: Failed to load PKCS#11 id at index=
: %u", i);
+            }
+            free(id);
+            free(base64);=

+        }
+        if (!error)
+        {
+            msg(M_CLIENT, "END=
");
+        }
+    }
+    else
+    {
+        int index =3D atoi(p1);
+
+=
        char *id =3D NULL;
+        char *base64 =3D NULL;
+
+        if (p=
kcs11_management_id_get(index, &id, &base64))
+        {
+            msg(M=
_CLIENT, ">PKCS11ID-ENTRY:'%d', ID:'%s', BLOB:'%s'", index, id, base64);
+ =
       }
+        else
+        {
+            msg(M_CLIENT, ">PKCS11ID-ENT=
RY:'%d'", index);
+        }
+        free(id);
+        free(base64);
+   =
 }
 }
 
 #endif /* ifdef ENABLE_PKCS11 */
@@ -942,16 +1017,10 @@
     {
   =
      unsigned int count =3D (*man->persist=2Ecallback=2Eremote_entry_count=
)(man->persist=2Ecallback=2Earg);
 
-        unsigned int from =3D (unsigne=
d int)atoi(p1);
-        unsigned int to =3D p2 ? (unsigned int)atoi(p2) : =
from + 1;
+        unsigned int from =3D parse_range_start(p1);
+        un=
signed int to =3D parse_range_end(p1, p2, count);
 
-        if (!strcmp(p1=
, "all"))
-        {
-            from =3D 0;
-            to =3D count;
- =
       }
-
-        for (unsigned int i =3D from; i < min_uint(to, count); =
i++)
+        for (unsigned int i =3D from; i < to; i++)
         {
       =
      char *remote =3D NULL;
             bool res =3D
@@ -1838,9 +1907,9 @=
@
     }
     else if (streq(p[0], "pkcs11-id-get"))
     {
-        if (ma=
n_need(p, 1, 0))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
-    =
        man_pkcs11_id_get(man, atoi(p[1]));
+            man_pkcs11_id_get(=
man, p[1], p[2]);
         }
     }
 #endif
diff --git a/src/openvpn/manage=
=2Eh b/src/openvpn/manage=2Eh
index 82c0caa=2E=2E1d2aff1 100644
--- a/src/o=
penvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -50,7 +50,7 @@
 #include =
"socket_util=2Eh"
 #include "mroute=2Eh"
 
-#define MANAGEMENT_VERSION     =
             6
+#define MANAGEMENT_VERSION                  7
 #define MANA=
GEMENT_N_PASSWORD_RETRIES       3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_S=
IZE 100
 #define MANAGEMENT_ECHO_BUFFER_SIZE         100

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d5=
9832b8
Gerrit-Change-Number: 2148
Gerrit-PatchSet: 1
Gerrit-Owner: Name of =
user not set #1000067
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--bOK+1JpZS7I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Name of user not set #1000067=
 would like Arne Schwabe to <strong>review</strong> this change=2E
</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">View=
 Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Implement multiline responses for pkcs11-id co=
mmands<br><br>Responses to the management interface commands pkcs11-id-[get=
|count] did<br>not follow the standard syntax, but instead looked like noti=
fications=2E<br><br>Introduce a new management interface version to rewrite=
 both commands to<br>conform to the common multiline + END syntax=2E At the=
 same time it is now<br>possible to query all PKCS#11 ids using &quot;all&q=
uot; or a range from &quot;start&quot; to<br>&quot;end&quot; - 1=2E Failure=
s to retrieve an id will return a partial response<br>terminated by an &quo=
t;ERROR&quot; message including the erroneous index=2E<br><br>The response =
format was changed to comma separated (index,id,cert_blob)<br>which is easi=
er to parse=2E<br><br>Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8<=
br>Signed-off-by: Marvin Wunderlich &lt;opdopiopi@gmail=2Ecom&gt;<br>---<br=
>M doc/management-notes=2Etxt<br>M src/openvpn/manage=2Ec<br>M src/openvpn/=
manage=2Eh<br>3 files changed, 167 insertions(+), 30 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/48/2148/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/man=
agement-notes=2Etxt</span><br><span>index 6c798c0=2E=2E299cd29 100644</span=
><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/manag=
ement-notes=2Etxt</span><br><span>@@ -619,21 +619,89 @@</span><br><span> </=
span><br><span> Retrieve available number of certificates=2E</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Example:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+Example for client version &l=
t; 7:</span><br><span> </span><br><span>      pkcs11-id-count</span><br><sp=
an>      &gt;PKCS11ID-COUNT:5</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+Example for client version &gt;=3D 7:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     pkcs11-id-count</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     5</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     END</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> COMMAND -- pkcs11-id-get  (OpenVPN 2=2E1 or higher)</=
span><br><span> -------------------------------------------------</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id=
-get &lt;index&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> Retrieve certificate by index, the ID string should be pro=
vided</span><br><span> as PKCS#11 identity, the blob is a base 64 encoded c=
ertificate=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-Example:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+E=
xample for client version &lt; 7:</span><br><span> </span><br><span>      p=
kcs11-id-get 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     PK=
CS11ID-ENTRY:&#39;1&#39;, ID:&#39;&lt;snip&gt;&#39;, BLOB:&#39;&lt;snip&gt;=
&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     &gt;PKCS1=
1ID-ENTRY:&#39;1&#39;, ID:&#39;&lt;snip&gt;&#39;, BLOB:&#39;&lt;snip&gt;&#3=
9;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+For client versions &gt;=3D 7 it is =
also possible to retrieve multiple</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+PKCS#11 identities from index &lt;start&gt; to &lt;end&gt;-1=
=2E Alternatively</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&l=
t;start&gt; =3D &quot;all&quot; retrieves all PKCS#11 identities=2E A comma=
 separated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+list incl=
uding index, PKCS#11 id and the base 64 encoded certificate</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+will be returned=2E If any id retri=
eval results in a failure, the returned</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+list will be partial and terminated by &quot;ERROR: =2E=
=2E&quot; instead of &quot;END&quot;=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+The &quot;ERROR&quot; message will include the index of=
 failure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id-get &lt;index&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pkcs11-id-get &=
lt;start&gt; &lt;end&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  pkcs11-id-get all</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 1:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Management interface client sends:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id-get 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  OpenVPN daemon responds with:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    1,&lt;id&gt;,&lt;blob&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    END</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 2:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Management interface client sends:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id-get 1 3</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  OpenVPN daemon responds with:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    1,&lt;id_a&gt;,&lt;blob_a&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    2,&lt;id_b&gt;,&lt;blob_b&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    END</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+Example 3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Management interfac=
e client sends:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id-get all</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  OpenVPN daemon with 3 PKCS#11 identiti=
es responds with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0,&lt;id_a&gt;,&l=
t;blob_a&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    1,&=
lt;id_b&gt;,&lt;blob_b&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    2,&lt;id_c&gt;,&lt;blob_c&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    END</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Example 4:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Management interface client sends:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    pkcs11-id-get all</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  OpenVPN daemon with 3 PKCS#11 identities fails to retri=
eve index 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    0,&lt;id_a&gt;,&lt;blob=
_a&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ERROR: Fa=
iled to load PKCS#11 id at index: 1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> </span><br><span> COMMAND -- client-auth =
 (OpenVPN 2=2E1 or higher)</span><br><span> -------------------------------=
----------------</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/=
openvpn/manage=2Ec</span><br><span>index 58f63e6=2E=2Ef33e881 100644</span>=
<br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/ma=
nage=2Ec</span><br><span>@@ -74,6 +74,7 @@</span><br><span>     MCV_USERNAM=
E_ONLY =3D 4,</span><br><span>     MCV_MULTILINE_PASSWORD =3D 5,</span><br>=
<span>     MCV_PREFERRED_USERNAME =3D 6,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    MCV_MULTILINE_PKCS11_RESPONSE =3D 7,</span><br><sp=
an> };</span><br><span> </span><br><span> struct management *management; /*=
 GLOBAL */</span><br><span>@@ -120,7 +121,8 @@</span><br><span>     msg(M_C=
LIENT, &quot;pid                    : Show process ID of the current OpenVP=
N process=2E&quot;);</span><br><span> #ifdef ENABLE_PKCS11</span><br><span>=
     msg(M_CLIENT, &quot;pkcs11-id-count        : Get number of available P=
KCS#11 identities=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    msg(M_CLIENT, &quot;pkcs11-id-get index    : Get PKCS#11 identit=
y at index=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(M_CLIENT, &quot;pkcs11-id-get i|all [j] : Get PKCS#11 identity at=
 index =3D i=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(M_CLIENT, &quot;                          For version &gt;=3D 7=
 also i to j-1 or all=2E&quot;);</span><br><span> #endif</span><br><span>  =
   msg(M_CLIENT, &quot;client-auth CID KID    : Authenticate client-id/key-=
id CID/KID (MULTILINE)&quot;);</span><br><span>     msg(M_CLIENT, &quot;cli=
ent-auth-nt CID KID : Authenticate client-id/key-id CID/KID&quot;);</span><=
br><span>@@ -889,31 +891,104 @@</span><br><span>         man_command_unsupp=
orted(&quot;cr-repsonse&quot;);</span><br><span>     }</span><br><span> }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static unsigned int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+parse_range_start(const char *p1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (streq(p1, &quot;all&quot;))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return (unsigned int)atoi(p1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pa=
rse_range_end(const char *p1, const char *p2, unsigned int max)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int from =3D (unsigned int)atoi(p1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int to=
 =3D p2 ? (unsigned int)atoi(p2) : from + 1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (streq(p1, &quot;all&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        to =3D max;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return min_uint(to, m=
ax);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_P=
KCS11</span><br><span> </span><br><span> static void</span><br><span> man_p=
kcs11_id_count(const struct management *man)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_CLIENT, &quot;&gt;PKCS1=
1ID-COUNT:%d&quot;, pkcs11_management_id_count());</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id_get(stru=
ct management *man, const int index)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
har *id =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
char *base64 =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (pkcs11_manag=
ement_id_get(index, &amp;id, &amp;base64))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (man-&gt;connection=2Eclient_version &gt;=3D =
MCV_MULTILINE_PKCS11_RESPONSE)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quot;&gt;PKCS11ID-EN=
TRY:&#39;%d&#39;, ID:&#39;%s&#39;, BLOB:&#39;%s&#39;&quot;, index, id, base=
64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_C=
LIENT, &quot;%d&quot;, pkcs11_management_id_count());</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;END&quot;);</=
span><br><span>     }</span><br><span>     else</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quo=
t;&gt;PKCS11ID-ENTRY:&#39;%d&#39;&quot;, index);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT=
:%d&quot;, pkcs11_management_id_count());</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+man_pkcs11_id_get(struct management *=
man, const char *p1, const char *p2)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(p1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((streq(p1, &quot=
;all&quot;) || p2 !=3D NULL) &amp;&amp; man-&gt;connection=2Eclient_version=
 &lt; MCV_MULTILINE_PKCS11_RESPONSE)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_CLIENT, &quot;ERROR: Listing multiple ids is only supporte=
d for version &gt;=3D %d&quot;, MCV_MULTILINE_PKCS11_RESPONSE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    free(id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
free(base64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (man-&gt;connection=2Eclient_version &gt;=3D MCV_MULTILINE_PKCS11_RESPONSE=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        unsigned int from =3D pa=
rse_range_start(p1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        unsigned int to =3D parse_range_end(p1, p2, pkcs11_management_id_c=
ount());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        bool error =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (unsigne=
d int i =3D from; i &lt; to &amp;&amp; !error; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            char *id =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            char *base64 =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (pkcs11_management_id_get(i, =
&amp;id, &amp;base64))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(M_CLIENT, &quot;%u,%s,%s&quot;, i, id, base64);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                error =3D true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                msg(M_CLIENT, &qu=
ot;ERROR: Failed to load PKCS#11 id at index: %u&quot;, i);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            free(id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            free(base64);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!error)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;END&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       int index =3D atoi(p1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
char *id =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       char *base64 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (pkcs11_management_id_get(index, &amp;id, &amp;base64))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;PKCS11ID-EN=
TRY:&#39;%d&#39;, ID:&#39;%s&#39;, BLOB:&#39;%s&#39;&quot;, index, id, base=
64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;PKCS1=
1ID-ENTRY:&#39;%d&#39;&quot;, index);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        free(id);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        free(base64);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span> }</span><br><span> </span><br><span> #endif =
/* ifdef ENABLE_PKCS11 */</span><br><span>@@ -942,16 +1017,10 @@</span><br>=
<span>     {</span><br><span>         unsigned int count =3D (*man-&gt;pers=
ist=2Ecallback=2Eremote_entry_count)(man-&gt;persist=2Ecallback=2Earg);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 unsigned int from =3D (unsigned int)atoi(p1);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        unsigned int to =3D p2 ? (unsigned int)ato=
i(p2) : from + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      unsigned int from =3D parse_range_start(p1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        unsigned int to =3D parse_range_end(=
p1, p2, count);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (!strcmp(p1, &quot;all&quot;))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            from =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            to =3D count;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 for (unsigned int i =3D from; i &lt; min_uint(to, count); i++)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        for (unsigned int i =3D=
 from; i &lt; to; i++)</span><br><span>         {</span><br><span>         =
    char *remote =3D NULL;</span><br><span>             bool res =3D</span>=
<br><span>@@ -1838,9 +1907,9 @@</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;pkcs11-id-get&quot;))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(p, =
1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
an_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            man_pkcs11_id_get(man, atoi(p[=
1]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ma=
n_pkcs11_id_get(man, p[1], p[2]);</span><br><span>         }</span><br><spa=
n>     }</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/m=
anage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 82c0caa=2E=2E1d2af=
f1 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ =
b/src/openvpn/manage=2Eh</span><br><span>@@ -50,7 +50,7 @@</span><br><span>=
 #include &quot;socket_util=2Eh&quot;</span><br><span> #include &quot;mrout=
e=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define MANAGEMENT_VERSION                  6</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MANAGEMENT_VERSION               =
   7</span><br><span> #define MANAGEMENT_N_PASSWORD_RETRIES       3</span><=
br><span> #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100</span><br><span> =
#define MANAGEMENT_ECHO_BUFFER_SIZE         100</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Dema=
il">change 2148</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2148?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2148 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Name of user not set #1000067 </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--bOK+1JpZS7I=--


--===============6295144442597714129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6295144442597714129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6295144442597714129==--


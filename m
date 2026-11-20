Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9D606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XTlbmHp8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mFhjd7FO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nSyyKimz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S16zPZKZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=pppi5s0DpImzBQAgtafdZBhK/5mqQLC7isFn01hGdBg=; b=XTlbmHp8EAlb90wjrDGosbz/o4
	NUopoO3eXivVuPlPXNoY53N6bNAk1AFqgtDUi5IXkbBOmsSvl/AVVj45Dq2SMCpbBDH4KxwJJ3V7K
	BiSpDK0VpFsV0l3PcvvZu60nqW8q4AqfcoU6PANirbLjeB7sk4gNnZhZVwx/1u2wikJo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUNtv-0000000009I-35pD;
	Fri, 20 Nov 2026 12:39:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUNtf-0000000008v-3sYw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:39:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AgVKpNDxSBcsEakSxx6A2mb50JHQLaHF7cua6yQFO9I=; b=mFhjd7FO4c78Q/y5cKWr8wQY4w
 /b5JzCUH80stizwUwq+v81E8n+ffa+ur9y06UVlWuHI365z1YaMJmT12DZ5eJr0brgw24PZvZlV0N
 UXAdEWvHztWO4VzG+UYlG69Oko7jPbfjz/RvX9otJLXbrICkSw5TL7PJ7Yr4DeHIFF+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AgVKpNDxSBcsEakSxx6A2mb50JHQLaHF7cua6yQFO9I=; b=nSyyKimzpkmb11jmOeErJP+13t
 nyQmBkApLh4OJWFsf2IIy5+D0tO+uVdLCgk/w4Tn/ee0pJrZzOdkQPB1pi28CtOuUw85zwz94RkrK
 OIarxBCwnEe/HKtwMlDY2VqYbuJEbQTxDN/zDnDmtoCuoqLP7ePrOKjHYKC7NBqRf2E4=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUNte-000000007yg-0Ud4 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:39:19 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so8704675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795178347; x=1795783147; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AgVKpNDxSBcsEakSxx6A2mb50JHQLaHF7cua6yQFO9I=;
 b=S16zPZKZ76Iwy96ZNT3f9Gi4wBJzHrCQK57a23cuwgDxbNBY/Ctcal90GHWXyBpn1i
 tWWi97PRc4Apta4C0q1WVRWwCM75rnSb/lS6GLoVXHiLgvXmgJUzFKB9HuCk0C+1ntDa
 QdkfRXfbDzHEsaq98B+gC/iWL57TY7NtG2n1hLJsPqt3TG39t6BC4O4j5lrPO4XIB6Vw
 cKGHUMys+Nv1rj5uTyuh2XX64RurwSQqJyxU4PrAVSAb/bXvPhVrZ5CMGjq8tljvF+K4
 QRlIEk63289uyu20C/vdltHwvT0XDW0hIhD17mWuMZIFnEws1Zx56tNWynkxogVKUD+l
 uxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178347; x=1795783147;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AgVKpNDxSBcsEakSxx6A2mb50JHQLaHF7cua6yQFO9I=;
 b=iHWOT/+aWPaKwB6XyKgHTXm8g3n8eNB63ST6v9YLUKJCA7Rk5Sf9/UDxyoOSXk9PBN
 Cuj2seQUnh+z24gmEpz9Fme6Su62A7wBpnx229eGBA3YXvs7c69EHgNLWo9YAK75BOA+
 gapYvPt2n7bNlrltxXv0t3lJZldlz9sAFTJflParqZ2L6RMbfSx3yDL3itvR++vP96HC
 YW7K7GUskgcf/P4S8Gy1QcK5fF5giFNCUdmOzlbhcEKZ+FakilTXojRmg0Ot5hTnqf3i
 UvhYdEKWFl9M7ACeNJqR4seAMDNAHCw79FUUD5obqDsMfhqgIV1AM8HtnaGHcb2knzQn
 SQ1A==
X-Gm-Message-State: APuU4Z/u+ObTrX7p9ipg+Lx8ScxuWadVCnnDOUeGA0Pfvt5t/y5bAZaI
 h41E6eW7AuM/7A0UO1q+fiP0/iByiXm+UGnhDfS6N4sKF7hCyXA2Ee0RIA8BxMOIK/sLXysVtPf
 BLt6i43OyORWcEwKAgyBJny3KAzTvWNgC1a61aexm78Ex5uJCZn/Rhl8wdvPcbbVKXTOzH7wKnn
 6RwtJqXw==
X-Gm-Gg: AYBFou2re13gjOrT0qOBpiV0oMPP1N9IWtQm/E9pE9rfNKxl7zD2v9GGqzf0eDDTB5g
 zrev/2TguD83MsnxgsauVYNSZmFFzTct11uKkTjWC5a6f4ioS8r+8qp6p6Z3tJnMbcsPQk04CeA
 /YSXLe+OeyUpq/RhzkJs/xy0+JQV8hWWEQV3icN8P1QDDmltrLumJCel9zJk9p6Dp611W+y7ayn
 ndOI9i+6ndksjmUQ3aOp4wDazr9LaujEDtrCV2PZHeqRMnBxgwecXaT4aDOfYXw8r6SfsQ3U4i+
 XeVMTK1IBDFiu2KNXRO8HWFXE7YKXkylHx+WEy6439siizYxBPelndtpxxIfcXEJa3h9WDnMU6c
 /rmgLEoUT3UqvW0oASYE66V61GeqwHieMtTKO7Bj6MvDmzsuOu9yVt9prD5BZAkVPbTb/yi2nfQ
 u28/khaT+J/9bUSBoXtrEHDB7roPfXYYNgks+wqD5CmLhXyzlcJDSm3UvYoAhDQ3TVbBntdWFOS
 DwWlvXspxQTnbROpdyFQUPaOhdoaJhflJF6dD81vfXhNxo1kF/wFgYi4Dlov7wbdQ1CosbtJ8KE
 yEovMxF9E+BWXEzB7drQj2+eCTwIrnv05YPUhZw0b6Zj1vu4HnOEp/Q/QrmrWB23SsKOzF7rVag
 0CX2ajapBJj32aC22GUcEZowiLsK8BM+7nclTloEGxT9j+QWQ+dKpwkpRChWZwykBz7QWpMw4h8
 0m80aWXByhNkn93ds=
X-Received: by 2002:a05:600c:4f42:b0:4bb:5c5c:8130 with SMTP id
 5b1f17b1804b1-4bb8881c726mr77987975e9.5.1795178347024; 
 Fri, 20 Nov 2026 04:39:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm75705145e9.1.2026.11.20.04.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:39:06 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 12:39:06 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I54c8bfcb14edf08292fa049c2275dcd518b7fc6b
X-Gerrit-Change-Number: 2229
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2229?usp=email>
X-Gerrit-Commit: f9d4ccf22f5365621f8bde955782941d7c00c1f9
References: <gerrit.1795178344000.I54c8bfcb14edf08292fa049c2275dcd518b7fc6b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc4MzQ0MDAwLkk1NGM4YmZjYjE0ZWRmMDgyOTJmYTA0OWMyMjc1ZGNkNTE4YjdmYzZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <604c1381f343ac61d80dee6465cedcd49788c277-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUNte-000000007yg-0Ud4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: drop
 unreachable branches
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
Content-Type: multipart/mixed; boundary="===============7377533993691941366=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7377533993691941366==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pgs9k29v9jk="; charset=UTF-8

--Pgs9k29v9jk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2229?usp=3Demail

to review the following change=2E
=


Change subject: options: drop unreachable branches
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: drop unreachable branches=


- The non-Windows --dhcp-option handler near --user/--group is
  shadowed=
 by the generic one earlier in the chain, which already
  calls setenv_fore=
ign_option()=2E
- add_option() sets file to "[CMD-LINE]" when NULL, so the =
file-less
  "Unrecognized option" message is never printed=2E
- usage() nev=
er returns, so the --help parameter check never runs=2E
- parse_hash_finger=
print() never returns NULL=2E

Change-Id: I54c8bfcb14edf08292fa049c2275dcd5=
18b7fc6b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/o=
penvpn/options=2Ec
1 file changed, 3 insertions(+), 29 deletions(-)



  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/2229/1

d=
iff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e51ece7=
=2E=2E5d0eb40 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -1156,13 +1156,6 @@
         }
 
         struct verify_hash_list =
*hash =3D parse_hash_fingerprint(line, nbytes, msglevel, gc);
-
-        if=
 (!hash)
-        {
-            gc_free(&gc_temp);
-            return NUL=
L;
-        }
-
         hash->next =3D ret;
         ret =3D hash;
     }
=
@@ -4071,11 +4064,6 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
  =
       usage();
-        if (p[1])
-        {
-            msg(msglevel, "-=
-help does not accept any parameters");
-            goto err;
-        }
 =
    }
     if (streq(p[0], "version") && !p[1])
     {
@@ -6651,11 +6639,6 =
@@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->groupname =
=3D p[1];
     }
-    else if (streq(p[0], "dhcp-option") && p[1] && !p[3])=

-    {
-        VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        setenv_foreign_=
option(options, p[1], p[2], es);
-    }
     else if (streq(p[0], "route-me=
thod") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE_EXTR=
AS);
@@ -7784,18 +7767,9 @@
     }
     else
     {
-        const msglvl_t=
 msglevel_unknown =3D msglevel_unknown_option(options, p[0], msglevel_fc);
=
-        if (file)
-        {
-            msg(msglevel_unknown,
-         =
       "Unrecognized option or missing or extra parameter(s) in %s:%d: %s (=
%s)", file,
-                line, p[0], PACKAGE_VERSION);
-        }
-    =
    else
-        {
-            msg(msglevel_unknown, "Unrecognized option=
 or missing or extra parameter(s): --%s (%s)",
-                p[0], PACKA=
GE_VERSION);
-        }
+        msg(msglevel_unknown_option(options, p[0],=
 msglevel_fc),
+            "Unrecognized option or missing or extra parame=
ter(s) in %s:%d: %s (%s)", file, line,
+            p[0], PACKAGE_VERSION);=

     }
 err:
     gc_free(&gc);

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2229?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I54c8bfcb14edf08292fa049c2275dcd518b7fc6b
Gerrit-Change-Num=
ber: 2229
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Pgs9k29v9jk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2229?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">options: drop unreachable branches<br><br>- The non-Win=
dows --dhcp-option handler near --user/--group is<br>  shadowed by the gene=
ric one earlier in the chain, which already<br>  calls setenv_foreign_optio=
n()=2E<br>- add_option() sets file to &quot;[CMD-LINE]&quot; when NULL, so =
the file-less<br>  &quot;Unrecognized option&quot; message is never printed=
=2E<br>- usage() never returns, so the --help parameter check never runs=2E=
<br>- parse_hash_fingerprint() never returns NULL=2E<br><br>Change-Id: I54c=
8bfcb14edf08292fa049c2275dcd518b7fc6b<br>Signed-off-by: Razvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file ch=
anged, 3 insertions(+), 29 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/2229/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><s=
pan>index e51ece7=2E=2E5d0eb40 100644</span><br><span>--- a/src/openvpn/opt=
ions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -=
1156,13 +1156,6 @@</span><br><span>         }</span><br><span> </span><br><=
span>         struct verify_hash_list *hash =3D parse_hash_fingerprint(line=
, nbytes, msglevel, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!hash)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            gc_free(&amp;gc_temp)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         has=
h-&gt;next =3D ret;</span><br><span>         ret =3D hash;</span><br><span>=
     }</span><br><span>@@ -4071,11 +4064,6 @@</span><br><span>     {</span>=
<br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>      =
   usage();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, =
&quot;--help does not accept any parameters&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            goto err;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>     }</span><br>=
<span>     if (streq(p[0], &quot;version&quot;) &amp;&amp; !p[1])</span><br=
><span>     {</span><br><span>@@ -6651,11 +6639,6 @@</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;g=
roupname =3D p[1];</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else if (streq(p[0], &quot;dhcp-option&quot;) &amp;=
&amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        V=
ERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        setenv_foreign_option(options, p[1], p[2], es);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     els=
e if (streq(p[0], &quot;route-method&quot;) &amp;&amp; p[1] &amp;&amp; !p[2=
])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_=
ROUTE_EXTRAS);</span><br><span>@@ -7784,18 +7767,9 @@</span><br><span>     =
}</span><br><span>     else</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        const msglvl_t msglevel_unknown =3D ms=
glevel_unknown_option(options, p[0], msglevel_fc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (file)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(msglevel_unknown,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                &quot;Unrecognized option or missi=
ng or extra parameter(s) in %s:%d: %s (%s)&quot;, file,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                line, p[0], PACKAGE_VERSI=
ON);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(msglevel_unknown, &quot;Unrecogniz=
ed option or missing or extra parameter(s): --%s (%s)&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                p[0], PACKAGE_VERSIO=
N);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel_unknown=
_option(options, p[0], msglevel_fc),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;Unrecognized option or missing or extra =
parameter(s) in %s:%d: %s (%s)&quot;, file, line,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            p[0], PACKAGE_VERSION);</span><br=
><span>     }</span><br><span> err:</span><br><span>     gc_free(&amp;gc);<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2229?usp=3Demail">change 2229</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2229?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I54c8bfcb14edf08292fa049c2275dcd5=
18b7fc6b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2229 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--Pgs9k29v9jk=--


--===============7377533993691941366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7377533993691941366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7377533993691941366==--


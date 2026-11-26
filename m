Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E0606A32D
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QSfnhnaR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BvjD51G2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gBXv/729;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XGAmDpjO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=0GZ3KOMN5xlEQk274tbYTffds4oTWifj3308cc1weoM=; b=QSfnhnaR5iXWMYD0jyR4V/BR74
	TH01SNwgxLuXFFQxudxfk8OqJtVFV31+5+61QzaTdijk8jo91Ji16CAfU8nfwju6PUnpwKT8f/J1H
	ajEADMs+ZixQWwrU3zmPryFQzLZy28uSGv20mUe25CFRkV74nxUClQIKrr5Bsd4ZtBWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXY3-000000002Jl-1d53;
	Thu, 26 Nov 2026 11:21:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXY2-000000002Jf-2oId
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LUiNxPFUcFQ+76XTR0o1sw/nJd+JJ/LNw/rX6AxhuYY=; b=BvjD51G2C3wCJo8fRpVa1lxgHR
 /Wr5gTOIFMOprFRYXcqLBawPHB4ArvJt+d9K5S0esQts1I+C/l6kCqa9ABDH+WYGZSg8uvHMH4UgQ
 +PzO6/L5j8aVS0tO6/4cWYIgM/C5voN0xQwj/qAFw2oi7Y5SNnptKcLF2RHNudJTe+24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LUiNxPFUcFQ+76XTR0o1sw/nJd+JJ/LNw/rX6AxhuYY=; b=gBXv/729+KVqkBK5/8SQyx/vv2
 skP3NJQ9UtWz/qRDEUqwCJLf53upjZfT94sFZjWbZDMSffg9+FZcghpmHnMw+dAEWaxSfuHhnlkpS
 ZcObRCqClPQ4Vx86xkaFZ64pz10y4WOAfVuyQSYqpny2kncq3gKDYbHHbLmTI55q10dQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXY0-0000000058Z-3zg0 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:21:54 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so4317312f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795692106; x=1796296906; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LUiNxPFUcFQ+76XTR0o1sw/nJd+JJ/LNw/rX6AxhuYY=;
 b=XGAmDpjOh0TvEfeyN+ylrYKZjTITvDjKH2FLPi71BcvX8UvjN3MBO98glBkGJbF9If
 BfLPe8kuhxVS1oB39FlfhOEwYOsavLJJ8R7qMq8d2DKWBj8WS5XBPNfq7yxlyrvGKpzz
 Kzh3FAFBxT2lDkfiaDMcZ/8phZSFgD4yEi9BmxOaPNjSY/zmrmNWilil9qsOzBsxBPmN
 KNzegllF9IiIYb/wY3AfMu3l8eGekiUyxbL2Meg6HUBdy+TFqZuqzI90Mmn+0Zo8WNNu
 WQdvEDHjhiQJdEpgYHFxhMyqRgFuc1L6G2Nx0muCC3IIsFlFPvt6xBq+M7N3/IXMVPSt
 OUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795692106; x=1796296906;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LUiNxPFUcFQ+76XTR0o1sw/nJd+JJ/LNw/rX6AxhuYY=;
 b=S01TtYydW8BX9MRNVezoyWgQuxLrKmrl93AdfQqjddng3RNFOjcXLM9xMED3Qf3Oa6
 i7FNEYGEqTUzrNuV4nziE8dUSQPivgf0yv4yTVmpd+CPHk5grO6Lv6D7xz49QPR+CjTC
 x044F20q8qLk0ndD7SrLroNj/L2jQgbz3pPlAT4RTJ103TH1Hv/Vtt+8S90/BsXcD+gP
 5yh6cN8H73If/tsrdUfixZMrVLLxMIpV2fnbEpICEe9+D87JYl9/P0Tbw8kmGtXc4/RN
 54Kq7RP1KxNTR1YX8zE7+QHRhKXZgnuPspYMXlp6IassQi40LYnfNm9vKuJOhazEtIY2
 yUzQ==
X-Gm-Message-State: APuU4Z830qk8U3JOA9uWEsiXrz0VESVMNb2nCWGTyv7AaTTHYwPKHNCi
 eLfdvhL4yMdfQCRaGPYV8lX40UvLhW4oJJcMRmJ876GD441UbgrogUlOPwgCX6MdTopDmDXU+kD
 yHZNQpHedpNFOnkx4itPkd0xfz9dw4WhGuT70oDWNBcXaf77KI4iNm5uGLhatubxf913wmLagLk
 DsUkUBrg==
X-Gm-Gg: AZFdTZegGDdsp4H2gXA2uYAE6g3WgNY5X3zXARZA5zMdVMRb2eIv9yG4ffsGtl72kYa
 TQjAl1VDRdM3SwtwFn9TPnKDu9tGkL6wE5lGW7rJPBTMi59itk7cL5ta5/Jnzk7gAtlpP6RBW5t
 AKlxyQfdGcP5BTCjQ2jToutuphMtWZ0p1ms8MxRitFE47VTNDyvoPQFUIhuyxkaS7E8jMxuutiS
 BC0byEaYsqcWu+X3zPdidCdbkj/fm1cApZ/7Mk2ai/ZhjnQ8HCuQ6nE481+naV3jtLkgLMWbBai
 lW/WvZCmCdv8cgUsz4IOtGCmNLoMnF4J1GJ5q5VbPOfnwRP2ZRKz6fXO2QA7RtP5+5iN6UqJ1wD
 +iq90Bks7wpEgaItAGWKejWr+bVi5TOlSp2iK/KWdMk8/s9jdeWsaVfcF8OWDGTEKLqka7DJDvq
 cPl1fRga7VSJ3Qi4gdVjjQ4n5SDqEuDCD52FkrgEXZcpsFiRY5PYqkHusksvF0ttH30MT/d9pKn
 n4OD8eXPIzuIMdyMb16CtfJSpAK2ECDk19JgxA6HF940PpILBj5+0HWVjU2g17MFGrfVKKlDlPj
 gsDVfp7r1CCNRpfc+6wXizpDl338yp2zz8rfklu2dJur60aRMjGRSq0vFlST4RypKyf1BB7I14R
 oz/d6GTu54YDkYURtBFxwEu+9/y+hS+X5bbEFW8S2oaAFGkysnY+u8DCeC7DJnzlXNSOS61YgRv
 CGZvpYYi6/MouO9YM=
X-Received: by 2002:a05:6000:4807:b0:490:39ba:4359 with SMTP id
 ffacd0b85a97d-4abb19c16f4mr35005510f8f.23.1795692105962; 
 Thu, 26 Nov 2026 03:21:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm42044361f8f.29.2026.11.26.03.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:21:45 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:21:45 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I26814847219a10bd0f311123ba44467b42e725e1
X-Gerrit-Change-Number: 2353
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2353?usp=email>
X-Gerrit-Commit: 41a6560a1695f7b9f8a20494867e91688479531e
References: <gerrit.1795692104000.I26814847219a10bd0f311123ba44467b42e725e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkyMTA0MDAwLkkyNjgxNDg0NzIxOWExMGJkMGYzMTExMjNiYTQ0NDY3YjQyZTcyNWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a7f792372a5c2c937b74bdca1c808f8516b03f07-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWXY0-0000000058Z-3zg0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: pkcs11: remove
 duplicated branches and a redundant check
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
Content-Type: multipart/mixed; boundary="===============1471786513167203653=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1471786513167203653==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AQQNvqnukfU="; charset=UTF-8

--AQQNvqnukfU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2353?usp=3Demail

to review the following change=2E
=


Change subject: pkcs11: remove duplicated branches and a redundant check
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pkcs11: remov=
e duplicated branches and a redundant check

- Merge the PKCS11H_LOG_ERROR =
case into default and drop the M_FATAL
  branch, both of which matched the =
fallback=2E
- In tls_ctx_use_pkcs11(), choose the id string first and deser=
ialize
  it once; set certificate to NULL once after pkcs11_init_tls_sessio=
n()=2E
- Drop the always-true rv =3D=3D CKR_OK test in show_pkcs11_ids()=2E=


Change-Id: I26814847219a10bd0f311123ba44467b42e725e1
Signed-off-by: Razva=
n Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/pkcs11=2Ec
1 file chan=
ged, 10 insertions(+), 31 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/53/2353/1

diff --git a/src/openvpn/pkcs1=
1=2Ec b/src/openvpn/pkcs11=2Ec
index 3610224=2E=2Ea2c9d2f 100644
--- a/src/=
openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -109,9 +109,6 @@
       =
      break;
 
         case PKCS11H_LOG_ERROR:
-            openvpn_flags =
=3D M_FATAL;
-            break;
-
         default:
             openvpn_f=
lags =3D M_FATAL;
             break;
@@ -145,10 +142,6 @@
     {
         =
pkcs11_flags =3D PKCS11H_LOG_WARN;
     }
-    else if ((flags & M_FATAL) !=
=3D 0)
-    {
-        pkcs11_flags =3D PKCS11H_LOG_ERROR;
-    }
     else=

     {
         pkcs11_flags =3D PKCS11H_LOG_ERROR;
@@ -589,10 +582,11 @@
=
         "PKCS#11: tls_ctx_use_pkcs11 - entered - ssl_ctx=3D%p, pkcs11_id_m=
anagement=3D%d, pkcs11_id=3D'%s'",
         (void *)ssl_ctx, pkcs11_id_mana=
gement ? 1 : 0, pkcs11_id);
 
+    struct user_pass id_resp;
+    const cha=
r *id =3D pkcs11_id;
+
     if (pkcs11_id_management)
     {
-        struc=
t user_pass id_resp;
-
         CLEAR(id_resp);
 
         id_resp=2Edefine=
d =3D false;
@@ -606,21 +600,13 @@
             goto cleanup;
         }
 
=
-        if ((rv =3D pkcs11h_certificate_deserializeCertificateId(&certific=
ate_id, id_resp=2Epassword))
-            !=3D CKR_OK)
-        {
-        =
    msg(M_WARN, "PKCS#11: Cannot deserialize id %ld-'%s'", rv, pkcs11h_getM=
essage(rv));
-            goto cleanup;
-        }
+        id =3D id_resp=
=2Epassword;
     }
-    else
+
+    if ((rv =3D pkcs11h_certificate_deseri=
alizeCertificateId(&certificate_id, id)) !=3D CKR_OK)
     {
-        if ((=
rv =3D pkcs11h_certificate_deserializeCertificateId(&certificate_id, pkcs11=
_id))
-            !=3D CKR_OK)
-        {
-            msg(M_WARN, "PKCS#1=
1: Cannot deserialize id %ld-'%s'", rv, pkcs11h_getMessage(rv));
-         =
   goto cleanup;
-        }
+        msg(M_WARN, "PKCS#11: Cannot deseriali=
ze id %ld-'%s'", rv, pkcs11h_getMessage(rv));
+        goto cleanup;
     }=

 
     if ((rv =3D pkcs11h_certificate_create(certificate_id, NULL, PKCS11=
H_PROMPT_MASK_ALLOW_ALL,
@@ -631,16 +617,9 @@
         goto cleanup;
     }=

 
-    if ((pkcs11_init_tls_session(certificate, ssl_ctx)))
-    {
-      =
  /* Handled by SSL context free */
-        certificate =3D NULL;
-       =
 goto cleanup;
-    }
-
+    ok =3D !pkcs11_init_tls_session(certificate, s=
sl_ctx);
     /* Handled by SSL context free */
     certificate =3D NULL;
=
-    ok =3D true;
 
 cleanup:
     if (certificate !=3D NULL)
@@ -764,7 +74=
3,7 @@
             goto cleanup1;
         }
 
-        if (rv =3D=3D CKR_=
OK && (ser =3D (char *)malloc(ser_len)) =3D=3D NULL)
+        if ((ser =3D =
(char *)malloc(ser_len)) =3D=3D NULL)
         {
             msg(M_FATAL, =
"PKCS#11: Cannot allocate memory");
             goto cleanup1;

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2353?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I26814847219a10bd0f311123ba=
44467b42e725e1
Gerrit-Change-Number: 2353
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--AQQNvqnukfU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2353?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">pkcs11: remove duplicated branches and a redundant chec=
k<br><br>- Merge the PKCS11H_LOG_ERROR case into default and drop the M_FAT=
AL<br>  branch, both of which matched the fallback=2E<br>- In tls_ctx_use_p=
kcs11(), choose the id string first and deserialize<br>  it once; set certi=
ficate to NULL once after pkcs11_init_tls_session()=2E<br>- Drop the always=
-true rv =3D=3D CKR_OK test in show_pkcs11_ids()=2E<br><br>Change-Id: I2681=
4847219a10bd0f311123ba44467b42e725e1<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/pkcs11=2Ec<br>1 file chan=
ged, 10 insertions(+), 31 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/2353/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span=
>index 3610224=2E=2Ea2c9d2f 100644</span><br><span>--- a/src/openvpn/pkcs11=
=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -109,9=
 +109,6 @@</span><br><span>             break;</span><br><span> </span><br>=
<span>         case PKCS11H_LOG_ERROR:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            openvpn_flags =3D M_FATAL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         default:</span><b=
r><span>             openvpn_flags =3D M_FATAL;</span><br><span>           =
  break;</span><br><span>@@ -145,10 +142,6 @@</span><br><span>     {</span>=
<br><span>         pkcs11_flags =3D PKCS11H_LOG_WARN;</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if ((flags =
&amp; M_FATAL) !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pkcs11_=
flags =3D PKCS11H_LOG_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span>     else</span><br><span>     {</span><br><sp=
an>         pkcs11_flags =3D PKCS11H_LOG_ERROR;</span><br><span>@@ -589,10 =
+582,11 @@</span><br><span>         &quot;PKCS#11: tls_ctx_use_pkcs11 - ent=
ered - ssl_ctx=3D%p, pkcs11_id_management=3D%d, pkcs11_id=3D&#39;%s&#39;&qu=
ot;,</span><br><span>         (void *)ssl_ctx, pkcs11_id_management ? 1 : 0=
, pkcs11_id);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct user_pass id_resp;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *id =3D pkcs11_id;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (pkcs11_id_man=
agement)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        struct user_pass id_resp;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>         CLEAR(id_resp);</span><br><=
span> </span><br><span>         id_resp=2Edefined =3D false;</span><br><spa=
n>@@ -606,21 +600,13 @@</span><br><span>             goto cleanup;</span><b=
r><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if ((rv =3D pkcs11h_certificate_deserializeCertifica=
teId(&amp;certificate_id, id_resp=2Epassword))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            !=3D CKR_OK)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(M_WARN, &quot;PKCS#11: Cannot deserialize i=
d %ld-&#39;%s&#39;&quot;, rv, pkcs11h_getMessage(rv));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            goto cleanup;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        id =3D id_resp=2Epassword;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if ((rv =3D pkcs11h_certificate_deser=
ializeCertificateId(&amp;certificate_id, id)) !=3D CKR_OK)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((rv=
 =3D pkcs11h_certificate_deserializeCertificateId(&amp;certificate_id, pkcs=
11_id))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            !=
=3D CKR_OK)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN=
, &quot;PKCS#11: Cannot deserialize id %ld-&#39;%s&#39;&quot;, rv, pkcs11h_=
getMessage(rv));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       goto cleanup;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_WARN, &quot;PKCS#11: Cannot deserialize id %ld-&#39;%s&#39;&quot;, rv, p=
kcs11h_getMessage(rv));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto cleanup;</span><br><span>     }</span><br><span> </span><b=
r><span>     if ((rv =3D pkcs11h_certificate_create(certificate_id, NULL, P=
KCS11H_PROMPT_MASK_ALLOW_ALL,</span><br><span>@@ -631,16 +617,9 @@</span><b=
r><span>         goto cleanup;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((pkcs11_init_tls_=
session(certificate, ssl_ctx)))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  /* Handled by SSL context free */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        certificate =3D NULL;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        goto cleanup;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ok =3D !p=
kcs11_init_tls_session(certificate, ssl_ctx);</span><br><span>     /* Handl=
ed by SSL context free */</span><br><span>     certificate =3D NULL;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ok =3D true;</span><br><=
span> </span><br><span> cleanup:</span><br><span>     if (certificate !=3D =
NULL)</span><br><span>@@ -764,7 +743,7 @@</span><br><span>             goto=
 cleanup1;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (rv =3D=3D CKR_OK &amp;&amp; (=
ser =3D (char *)malloc(ser_len)) =3D=3D NULL)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if ((ser =3D (char *)malloc(ser_len)) =3D=
=3D NULL)</span><br><span>         {</span><br><span>             msg(M_FAT=
AL, &quot;PKCS#11: Cannot allocate memory&quot;);</span><br><span>         =
    goto cleanup1;</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2353?usp=3Demail">change 2353</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2353?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I26814847219a10=
bd0f311123ba44467b42e725e1 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2353 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--AQQNvqnukfU=--


--===============1471786513167203653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1471786513167203653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1471786513167203653==--


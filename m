Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB70606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X85P3a0V;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fErNYTrd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WY1oh0CX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=E10KyeLX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YMiU/cnJQKn0Jpxor1sjlKPmuaLnGA7a5crCBMHTz5g=; b=X85P3a0VsCt2o075qJGp+apt25
	jtvOHG+FEKZgN6rBYbmjXudCeTV0Sg/RyIFVck01FVPxvelmM0AVLolbhB0gf20Nd9GDrAweUO5iY
	ugXKHvRqgL8B7rKI1QhsQ5YBD4JMoGx+m2aQBve+x28pRUw27rXRqVPvC7hKfMfQW/bk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVPJB-000000004ac-3z5z;
	Mon, 23 Nov 2026 08:21:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVPJ8-000000004aD-2xOv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ctmuqRKq6y3038+xXBg/lpf3CWUm7maghevkGpcskBA=; b=fErNYTrd6zY+Cwyyy+jiuGoRB6
 4kmrXK2rfB9XeMr6h2pa3B51LMn8f+xn3aLK3k4NeClDs4ObAmwO1sJYiWOTOAy9fEovezw1GIcvg
 4xfogYeU8cA+fEUpTNm5XD19OSzbRymY/wU1BDAOc/VZZH0KlkxgoqK0N3qm6VrlgQZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ctmuqRKq6y3038+xXBg/lpf3CWUm7maghevkGpcskBA=; b=WY1oh0CXrBUkGHsvKlNZaWjR2V
 JKaWuIZO5LcYU6js1VK/XLBlxxos0rHQ91FPEcusXoDpfF5rW6GUP9ZEBzr+1W/9i4MEG1IoBpQ7S
 vQwhGf+dzTOkozAiJ3ffjMLUf0z5YaNoClBPeBVw2Myv0zP/5aUSrLHxi5jY3x54LrcU=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVPIg-000000006CQ-3m3Z for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:21:24 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so26913565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 00:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795422076; x=1796026876; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ctmuqRKq6y3038+xXBg/lpf3CWUm7maghevkGpcskBA=;
 b=E10KyeLXGAXS5MrY08ox9R+0YexCLpUZZjD2Mzv+rleZ58p1lV3ZBD+y2v+Fl849SI
 g+Gdg8zLNnTTACP55qmksj+0nCpCQ1Qh/s1mRsX5T+6NaDXYTAVa5y4WYQWMvwdxmtRm
 pBSGF3GfsSzyOiLgGzAQ06Zw9lQtpO0mBp6ZiT5gTldR+CZAOvQvotBiW1V+MoVY3/5S
 GsHUJK2emYLdV5ibzeTQnyu10n0r6anB9akBmcKK4ud9RnWgU2BSY0ihar0aQtBf8JOi
 B9NeU4S1TKXBV63AEQUG6ud2yZR09BvzY+1M0Q43XhR4pMdRfgFCuom0EcdlBXkKBSUb
 4cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795422076; x=1796026876;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ctmuqRKq6y3038+xXBg/lpf3CWUm7maghevkGpcskBA=;
 b=tr/4ZeT0wzTAMofqbFGAKVPMtvZ71W7CR1YOYaeeHnuHeimjtMGAUvTfC9vQgJXjKd
 iOm7WM4ZTdVg/qNm7vd4DMNBpJixkTe27NqOXJuFonKxzHg9DV5xb5gDXdZVw6xQ7KWU
 0uUrpDLD2ZwlIN5n4iJnSaytp/i8A8rGvozndFgJSODb7OFiGom7HCUPMMbOyU5l21+9
 Xcvo+CUVEKg1HKRrS1wCOnfe4WFqlL1H/U2BrD11PZ48r/TH3VORu+TVZdBOjdAxbTK7
 KmXzXK6OT60BEa1d1mBLMcHRsZ1quH33xwsnqMM9F9zymdr/AgB5eeSv8P9pwEPDcsR9
 cXFA==
X-Gm-Message-State: APuU4Z/v0UwC/ASnIvw08ByLTDf/G6JtTL2HkWdjhI+SWkVLWDwIpQnt
 aknA8u5LnpUegNR2Ga10hEbLHy/m3t0djaJh8pahV0g35ND7GFB7fFl1X7KUHSTUpPYc1qWzRav
 /kyfX3z+JSUoHtdPKILLMOoTZc4OVm0+I1l4ZmfqXSyxgIQ4enLEUEyM2Xotfs5GrKPBL
X-Gm-Gg: AZFdTZf8+jsRRu2Ik+bCPbxusFJEO3E0EpXeDT/+qI7tx/qy17Y2/ECqmk+b0p8GyoI
 4UT5N+5gFMkBnFhRB3s8xwoHxcHbEtxKqD328qJG8OhSEgJHX/Sr1rbAzJcTvFhA2rCUtKbsZlw
 UTwPAS8BGPvvBbaXB3dRydgtE5EtcX7ZbLHBSvPVWt16i0Rx58t+Wh0gTeUi3dsnIkCKOgEENW1
 PWj2sWwEAv+jXDUrfEx/rLN3N6c/aQORdMtDEB7EB4RnZHqlWVrEkHzdVCFx1ANugFHdUWow5ZQ
 6z5VyxC4euT8KWohuur6ua2NH8BzgxK9Yy3xr5SHJxOoJ1XUe0MUjIP/JCuy0PAvPdVkAHRwHFn
 E1bxKNdAJUwjs1qS3ysUkoHq3Qp6+QKohGgXUitGLqkFVQt17I7uOa8hQkDnqZANqW8OWaO0slJ
 GBAeF+FLGbk0SKdXdDCGA5KmAKEWCgT8Vz6Z6UbF3K1ccgoFZp/xUht9d1TpyG85+CGXX+jlNU1
 u/5Hwt9KlDKdq/M/d4xbYXxANa7/+EFh8IM/nU65X9Zz+nfSxvYlLWuhfzHQhYpw0cyAZpEd7y8
 XIRcmClaKGt62joUHZ1+kYWZL5apmJGt8wHyMrx+kriXslsl1ZMk7DHTs1dBzylWt8NdEp4elWi
 C5YPbfABNpDkBjtckSsi1B0WH5Gh1BYuokMYAb+gvn8RIt4tk6uJSoDlSlvEejwM0TOUl+LFmBl
 ixU+SomBSVDpr2exdHXNEb1r2AODrsc+qJeR4f
X-Received: by 2002:a05:600c:c168:b0:4bb:81b2:c801 with SMTP id
 5b1f17b1804b1-4bb889238f1mr215775195e9.20.1795422076117; 
 Mon, 23 Nov 2026 00:21:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm291376595e9.8.2026.11.23.00.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:21:15 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 08:21:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
X-Gerrit-Change-Number: 2231
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2231?usp=email>
X-Gerrit-Commit: f7fe6f8f1715dc3943be629a057739cf3fff0725
In-Reply-To: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
References: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwNzAwMDAwLkllZDY1MjAyZDI2OWRlZGZhN2NlNjllNjJlZjY4ZDc3NWVjMGRhMzZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <676bb4634c8315261a0c3eed49da2f2ea95e0b71-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVPIg-000000006CQ-3m3Z
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: use
 report_command_status() for client-deny, client-kill, pus...
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4505222892746593539=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4505222892746593539==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2+VNvaa2v2Y="; charset=UTF-8

--2+VNvaa2v2Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2231?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: manage: use report_comman=
d_status() for client-deny, client-kill, push-update
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: use report_command_status(=
) for client-deny, client-kill, push-update

These printed the same SUCCESS=
/ERROR lines by hand=2E Output is unchanged=2E

Change-Id: Ied65202d269dedf=
a7ce69e62ef68d775ec0da36c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231
Message-Id: <20261122113822=2E710=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg41785=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 3 in=
sertions(+), 22 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/31/2231/3

diff --git a/src/openvpn/manage=2Ec b/src=
/openvpn/manage=2Ec
index 86c498e=2E=2Eab814d5 100644
--- a/src/openvpn/man=
age=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -1286,14 +1286,7 @@
         {
    =
         const bool status =3D (*man->persist=2Ecallback=2Eclient_auth)(
  =
               man->persist=2Ecallback=2Earg, cid, kid, false, reason, clie=
nt_reason, NULL);
-            if (status)
-            {
-                =
msg(M_CLIENT, "SUCCESS: client-deny command succeeded");
-            }
-  =
          else
-            {
-                msg(M_CLIENT, "ERROR: client=
-deny command failed");
-            }
+            report_command_status(s=
tatus, "client-deny");
         }
         else
         {
@@ -1312,14 +130=
5,7 @@
         {
             const bool status =3D
                 (*man=
->persist=2Ecallback=2Ekill_by_cid)(man->persist=2Ecallback=2Earg, cid, kil=
l_msg);
-            if (status)
-            {
-                msg(M_CLIE=
NT, "SUCCESS: client-kill command succeeded");
-            }
-            =
else
-            {
-                msg(M_CLIENT, "ERROR: client-kill comm=
and failed");
-            }
+            report_command_status(status, "cl=
ient-kill");
         }
         else
         {
@@ -1523,12 +1509,7 @@
   =
      status =3D (*man->persist=2Ecallback=2Epush_update_by_cid)(man->persi=
st=2Ecallback=2Earg, cid, p[2]);
     }
 
-    if (status)
-    {
-        =
msg(M_CLIENT, "SUCCESS: push-update command succeeded");
-        return;
-=
    }
-    msg(M_CLIENT, "ERROR: push-update command failed");
+    report_=
command_status(status, "push-update");
 }
 
 static void

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775=
ec0da36c
Gerrit-Change-Number: 2231
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--2+VNvaa2v2Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2231?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">man=
age: use report_command_status() for client-deny, client-kill, push-update<=
br><br>These printed the same SUCCESS/ERROR lines by hand=2E Output is unch=
anged=2E<br><br>Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c<br>Sig=
ned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2231<br>Message-Id: &lt;20261122113822=2E710-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg41785=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 f=
ile changed, 3 insertions(+), 22 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/2231/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><b=
r><span>index 86c498e=2E=2Eab814d5 100644</span><br><span>--- a/src/openvpn=
/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@=
 -1286,14 +1286,7 @@</span><br><span>         {</span><br><span>           =
  const bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_auth)(</span>=
<br><span>                 man-&gt;persist=2Ecallback=2Earg, cid, kid, fals=
e, reason, client_reason, NULL);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (status)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                msg(M_CLIENT, &quot;SUCCESS: client-deny command succe=
eded&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_CLIENT, =
&quot;ERROR: client-deny command failed&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            report_command_status(status, &quot;client-=
deny&quot;);</span><br><span>         }</span><br><span>         else</span=
><br><span>         {</span><br><span>@@ -1312,14 +1305,7 @@</span><br><spa=
n>         {</span><br><span>             const bool status =3D</span><br><=
span>                 (*man-&gt;persist=2Ecallback=2Ekill_by_cid)(man-&gt;p=
ersist=2Ecallback=2Earg, cid, kill_msg);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (status)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                msg(M_CLIENT, &quot;SUCCESS: client-kill comma=
nd succeeded&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_=
CLIENT, &quot;ERROR: client-kill command failed&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            report_command_status(status, &quot=
;client-kill&quot;);</span><br><span>         }</span><br><span>         el=
se</span><br><span>         {</span><br><span>@@ -1523,12 +1509,7 @@</span>=
<br><span>         status =3D (*man-&gt;persist=2Ecallback=2Epush_update_by=
_cid)(man-&gt;persist=2Ecallback=2Earg, cid, p[2]);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quo=
t;SUCCESS: push-update command succeeded&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    msg(M_CLIENT, &quot;ERROR: push-update command failed&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    report_command_statu=
s(status, &quot;push-update&quot;);</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail">change 2231</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie=
d65202d269dedfa7ce69e62ef68d775ec0da36c </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2231 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;=
openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--2+VNvaa2v2Y=--


--===============4505222892746593539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4505222892746593539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4505222892746593539==--


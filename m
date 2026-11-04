Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490A606A32C
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CU4kiFpQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fL6tdSfp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RNukjALQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fwnkYqXo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SteYFIt3T27vyJElyMPJbfFbz7imSlVSrm9Q0VMFOms=; b=CU4kiFpQxn29UeybbbdniA+vTJ
	5JlaC/Gd6fe6aMYLbAWqWLw8lAPRhNeZDhwrDDcRgXjg8c04xePk6yGsX5s3bzyd6/Ko4NFRmAnfr
	1/Na6lLhctFt5WdVXN513zQJGQTZALATXUhLMLtqhxx9yM2URXPhYNbD7WzUdVK0rDKI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeGy-000000005lV-28A8;
	Wed, 04 Nov 2026 16:55:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeGx-000000005lO-0RCh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:55:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tnOQSNWuepnjpbKV1dJLknDAbzm7tG8gnyq7NyVkDKo=; b=fL6tdSfpXK/5ew7zUuZ52VA8ef
 mq5eN/nXcFQ2YYZa0GOrvwSxBEE97D6iPfCLdKJNHEcl7nku094CaTmzvQTs4KZOlu0cIjNAiNwjH
 Z58Ejh6hrmdACHV9YfkNwZxuGTypFX3+Pow5kZSviFi59rJ+UvmDkZpMxAjackw/NZy4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tnOQSNWuepnjpbKV1dJLknDAbzm7tG8gnyq7NyVkDKo=; b=RNukjALQGfjiPVvO7wU8neo5BL
 Pa4wG+vmxzzk+KWB2kS+9g2dgwlNIWyMbvWjY6BMwbKx0Xh5eUqFE/8HVBzT+FROnVscOODgfbxvx
 heIU3mLYl17cHm2yOHOEJ/JYKtIuF8Jvn3Awe5eVe6bHxIcQJBmO//S+muu56jDw7Kak=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeGw-000000007H2-0e6w for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:55:38 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so7956465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811331; x=1794416131; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tnOQSNWuepnjpbKV1dJLknDAbzm7tG8gnyq7NyVkDKo=;
 b=fwnkYqXoLY2sIfJAuCedV6xH44DfVhNDLa32ev1k0rLNXX+DGLdHeKJLfWQVcV6lYm
 vyGEjU3InGCrBhwznSFIKz1RpY5N8ghxZ8h5fT1LeYYHKJ5GaoLNQ1EraHpcigUeOnZy
 6nEi3s3iY0IjGOqI5aPRjbFozYlex0nbvfIg5+5CV3rzqTUGPl0YNB8zhODxWO46gF/b
 gX0wyKJRol79A3fIyJY1pJEqjAFzgKewPytpT1VbDp3KdnhuECfmuvUufEhUZ247nA5B
 LUyNubGcV5uROfZgC6UxbQxuF0AIv3f/31cjnNdogmP3T510JohagPXKpy0wBL1+V2Nr
 Qtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811331; x=1794416131;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tnOQSNWuepnjpbKV1dJLknDAbzm7tG8gnyq7NyVkDKo=;
 b=1rhV+oriQCa2UfKOv6we+dHgHf0zjIqSx6aAECPPItUdn3m50PXo16UGrBIrdbmeql
 pndGDiQ+/40IYb8IKEdAQt5RAyUYnr5AqNiIjhAYlky9THL1gFFK1qGbwmJdHCRPI5kJ
 i4mHKtHfP2n9vBnNqjUlDDHIGEL2HDvJMVlgS7o7/xfIFaFqXsGNWdjHeI7hizGfjBZR
 wAfLZDyE0FRVYGWtJCpnQUzXx4Hy1qzySuicCE96upvWM2I3Hsayuje1J0LSoOeRoIa5
 le5EOR0H1WSQFwgMD2yI9v350yvNerI73UVRj8i1+QRspSEcU/BADNJ7xGrsXN3cOLab
 PQBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQvFnpl4XCXhcORdhtWUDCxeYnp+VCKnadLriJDtXuDk7+PzWowWuOXEWoIaBoukYELMfXuMxMhWhHSUCv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+ble6kopwXi5KnfGadHKsfWkjfKKRjX/dog3p98GoC+mSgJreb
 1wNZdbgdQdXnVtDcDuuAh0jXxKiTEiDiuhZU6ylk6ZB4G4ed9FB82oPCh6g2XLSYV9CMuL/D7/U
 Rd+3GNTAOfffMB9CNCIK9h+lxEo7cr37mIxIm9SSpBXSRWJILh8uj3Z7oFEzDE87y9pE3
X-Gm-Gg: AYBFou0UPHfeQIIr7CGbZpqgDT8vRJWsL9HvWPw5qAai9hHPm4tHKy7mbkHatzGviZt
 OHGJw4jI+3iZmGQzD038qT7KBnLiXIXh4U3Y4pEfy6Y14WULdsZ1EWZSoD6xDEtlS6UOFBHTAth
 rLanzxM8YVRQTrfIEXAy+4pwXm/rYEGcGZCBg397JNqii9XqBxgqhnVNND7VnVm6Z9CDi8Lal6o
 U0/8dTaUe1ddW/9gENXCxLLgFqVT7FhpKs69x07IRLDwyU/966HcDn50rTcIfJGtGCYULzVVPZ1
 SfdhSz8H2Us6Hl9Ulpmvamz6NEnbz/Z7tWFt0D0I2kdoLiOtuwupP+b4QzU9VITaYm/PkWjZgXY
 UwzA3wefdblYGA3Ek+Uy8JbEN3szlM2jhJb8SCRFLziHQmCd/WkxBSteb56vWT+5wP+FotshenY
 IyhmLgYgxaSyyiSroh3r3iyZYE6LIPxqqVkYKgQ0f8yycgCGw8TBwAUh4mqMVFB+FckQ5nwtSyQ
 8hwGrI8HFDcQS5KnfE2Rasxbk0EEopImPQSZfgWIUk51i6rvuXtZHLI37q7tk6e0Jc5a0YR0hMv
 AXH+qOJqdob/MncLS4Tn3iuTlh8aLmg5+6b9dk4LPZSqt5ggATMV3yeWOo6YGG8JvQ9aesJ0W5H
 JdQQjlNQt4wLSBieuqKBSfgVrX0ThGWyUsMQmimgN8e4BaLU2MtsaDkXMFiaUmtPk9sz2uw5xHK
 C1Z6I/LIUKu1+2pkY=
X-Received: by 2002:a05:600c:6387:b0:4a2:150f:1605 with SMTP id
 5b1f17b1804b1-4ac1904a81amr386210535e9.24.1793811331467; 
 Wed, 04 Nov 2026 08:55:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa5781c9sm166277105e9.8.2026.11.04.08.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:55:31 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:55:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd
X-Gerrit-Change-Number: 2127
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2127?usp=email>
X-Gerrit-Commit: 6649526a4da30e3234ec3386133c50b9c5e83a17
In-Reply-To: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
References: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxNDIyMDAwLkkyZDY3N2VlYjZhZTkxODZlZGUyYWViM2MyZTBjMTJkMjVjOTM1ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <762bf20b26d5e609422ed76ed7cba2a299af26ae-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeGw-000000007H2-0e6w
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: return NULL
 when the second adapter info query fails
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
Content-Type: multipart/mixed; boundary="===============4707485236149482693=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4707485236149482693==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RDlbAOSDeEs="; charset=UTF-8

--RDlbAOSDeEs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2127?usp=3Demail )

Change subject: tun: return NULL when the s=
econd adapter info query fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

tun: return NULL when the second adapter info query fai=
ls

get_per_adapter_info() and get_interface_info_list() returned the
alloc=
ated but unfilled buffer when the second GetPerAdapterInfo() or
GetInterfac=
eInfo() call failed, so callers read uninitialized data=2E
Return NULL, as =
get_adapter_info_list() already does=2E All callers
check for it=2E

Change=
-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127
Message=
-Id: <20261104124842=2E18381-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=
=2Ekernel=2Eorg/openvpn-devel/20261104124842=2E18381-1-gert@greenie=2Emuc=
=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openv=
pn/tun=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)




diff --git a=
/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 225d8b1=2E=2E7637dc0 10064=
4
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -4129,6 +4129,7 @@=

             {
                 msg(M_INFO, "GetPerAdapterInfo #2 failed (=
status=3D%lu) : %s", status,
                     strerror_win32(status, gc=
));
+                pi =3D NULL;
             }
         }
     }
@@ -4158=
,6 +4159,7 @@
         {
             msg(M_INFO, "GetInterfaceInfo #2 fail=
ed (status=3D%lu) : %s", status,
                 strerror_win32(status, gc=
));
+            ii =3D NULL;
         }
     }
     return ii;

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c1=
2d25c935fcd
Gerrit-Change-Number: 2127
Gerrit-PatchSet: 2
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--RDlbAOSDeEs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2127?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tun: return NULL when the second a=
dapter info query fails<br><br>get_per_adapter_info() and get_interface_inf=
o_list() returned the<br>allocated but unfilled buffer when the second GetP=
erAdapterInfo() or<br>GetInterfaceInfo() call failed, so callers read unini=
tialized data=2E<br>Return NULL, as get_adapter_info_list() already does=2E=
 All callers<br>check for it=2E<br><br>Change-Id: I2d677eeb6ae9186ede2aeb3c=
2e0c12d25c935fcd<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127<br>Message-Id: &lt=
;20261104124842=2E18381-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=
=2Ekernel=2Eorg/openvpn-devel/20261104124842=2E18381-1-gert@greenie=2Emuc=
=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---=
<br>M src/openvpn/tun=2Ec<br>1 file changed, 2 insertions(+), 0 deletions(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</=
span><br><span>index 225d8b1=2E=2E7637dc0 100644</span><br><span>--- a/src/=
openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@=
@ -4129,6 +4129,7 @@</span><br><span>             {</span><br><span>       =
          msg(M_INFO, &quot;GetPerAdapterInfo #2 failed (status=3D%lu) : %s=
&quot;, status,</span><br><span>                     strerror_win32(status,=
 gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   pi =3D NULL;</span><br><span>             }</span><br><span>         }</=
span><br><span>     }</span><br><span>@@ -4158,6 +4159,7 @@</span><br><span=
>         {</span><br><span>             msg(M_INFO, &quot;GetInterfaceInfo=
 #2 failed (status=3D%lu) : %s&quot;, status,</span><br><span>             =
    strerror_win32(status, gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ii =3D NULL;</span><br><span>         }</span><br>=
<span>     }</span><br><span>     return ii;</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Demail"=
>change 2127</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
27?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2127 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--RDlbAOSDeEs=--


--===============4707485236149482693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4707485236149482693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4707485236149482693==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21C606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RYYm567f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fX2+0g2x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MgSobLHF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L5Qko8w3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8RygP76gcOyVMIh5spPX2lhD/jAsQdoAckSniEnGX1k=; b=RYYm567fVrvKsDrh6NKtVCQr3N
	ySTUsfImO8TfEDAM1vdXURLoE41miiKZcgeXZWdjOJYpzWzQxF0xHMihcvWA6+exQbFTAehdcRcN7
	SNe7UWZC8N+UbjGQIQYJI7yyMnOOcTPcbdwXSVkwit1nTpnJTzvv18Wo5bGXl8C30Lh8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStMl-000000000v3-1z5M;
	Mon, 16 Nov 2026 09:51:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xStMj-000000000uo-3C4I
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z84YdVVV15wDfv7kMwLxC5h4wz0wiKc1VdzxS28Lj0g=; b=fX2+0g2x81QZMYinCxFV4nnlo1
 gJaZxYFgiNE3ntK6FC9r9wlv8POywDp/rCkG6GA/rEPGhGXKFRwl6zEkhkPEGxuDL9yxtyc6UhHbc
 9Av+o1ieI0aTTRiNldgilt9qMdyPPF0zhySAvwK+25WZm3lkzZ1UxDS3ovnai5mHyLL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z84YdVVV15wDfv7kMwLxC5h4wz0wiKc1VdzxS28Lj0g=; b=MgSobLHFJRwjjQTESEHHITIuQ/
 MbxBMkdSW4cI8HqjVlRPvB4ogqKvuqdAAPKXF3FQiBKOh6ZYLSSSz154SW+HwQmGDn9Q9lTvAF8Pk
 jpxLrsqKYNHnUYYnkPRM6yxCEkYOJcWyV3LgpswRKmuNGWcGwciEmjlK5gQl5q9sHgdM=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xStMh-000000002Gh-1Z1F for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:51:09 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so26219335e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794822661; x=1795427461; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z84YdVVV15wDfv7kMwLxC5h4wz0wiKc1VdzxS28Lj0g=;
 b=L5Qko8w3ZAzU88HydBWbumNak+UKqCDDB5bGk4xQxuoWC7KunCzB41YBbL7RqtAd1N
 qnEsxI1pfbDnGFtdZgB1/iZdY3hz9RMS2AT/QHj4BUz+r6ja0uY88xF5BbF/z3ZTJEAQ
 vM7qhjfgd6WjlQkZ/dbhnUTFPDgqhybiFV8biMRL9828tyuXvQ86Lqv99IyCFm4Lvn1e
 kBEBmsP3C9ikYHoUFY5Rs7jxBjQvLPU9Ox7+rbyzB2Svmh8zpPu1WnGOQY6tQmlV4rhi
 xNVrrAEq03INKeU9sW+rSRFhNnD6PtcbCBiXYVtFTptp9LK0KGX5e99vmYHDDKusYKpV
 LTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794822661; x=1795427461;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z84YdVVV15wDfv7kMwLxC5h4wz0wiKc1VdzxS28Lj0g=;
 b=iUX01ZwLGETHQct/A1GKeQwSVUj4mGnVdUw4QqG+DBbfTMMjJ6jJIut6Byo8NS/T5l
 t4mF4qpqqr/Iqkzt8+PITFySvRpI2pbzRI5kCmgLa0d3Ysf3YXXOBcf+PRN6bq6QoKy5
 8PtZAjboucfeU2jU8dTyZycD1devF2ArBuCmvUHOmS8WgTs8qPU9wNgDD542TO5GfP/n
 TKYCziRyA+8wSPi3txcZ7Qo6nURmetAOr20QdY8t9oHQ/RnBXv0aw0kh1tQrlMOv1aw6
 Noxak3MNFgPLCOV9gmeo6nydKO1apeYILrbMlaGdNTC/Jin7SDAWJb0fnYwxMUJnjHuv
 pwsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEvn9lcwPFydtJ+lax7aNfJtdE+/q4c1scP7SImz8fLtWQjjiNc+qKNUj/4Mq763q15qrx6MMNVE8RMYohb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+LBIAwP4rP9Cv0LbvmyMKWmW3l98W2hn9IcsSRf526oKq064PV
 4yRF5rgFG6ufAaf69ntq9I9zv9sqFeewNrLfthXZ189/JidZauEsa+/MFhBzhXGGIDbXWYFxwp9
 lcgtU2TJ9T713cwr0Gk3uTOPuxQ4wwtuJiQ5YgyXHPjTSiQ0sOjzQ43wocH7sTa/H6Udo
X-Gm-Gg: AYBFou0t+4zhksz5tMmHqnGliP3pPx3J7eWnAyYDO+71zfx5kh+4la/HAou6+O4giJ0
 VRI82n7ogI7lR2OlF7cVn0z/8doLoZWk8qf3LihXsoMbc+nrVCxMnB9xjcs6qFn+BiMRIl7f9KP
 Q+or6SjnOqVvPc+HSUEnWiR8Vf3Unr3olkxeZUiXrxcj/H5BZANhvcWjuwmOybyyYq3X3un24Wy
 Zf7sD7/gXgaMIJfzaE882YMGCCtIygAMMFfdPylRMIhIhqayDUhZdzB26mSXcKTIGqW+pZUnWex
 xCXfg9Bmq0FCLqzATwNeMtubVv7r1Sxp6wabp7iVZfqWgmNEHKem42u0gmvHcUJj1TSW9qwmOzh
 MSjWhlqVWjXdRauElubJbsm262rTKgFKSFmRPbGp2TxTiZ0yELkRWgaTmpVO0JV+RImd/XLuOJL
 Q4dDTCBG4v2IynL7RTaiDK0M8pjgwyaWKHBOHiEEXJWpEhsUbp3vii4p/E4qi/UfuJnKPKKUEn9
 Uwv3HtnvX2cWeB1NvJ3t54bOvHs83ag38wpGWr4Z0+3aulRtkjSx7IcxeJvm19ONFDMM6sUdl8S
 Gq6cgGajoNDVpLlz58pDh+0X2mT75o5x31PZsYz1RW+SmWbbEBDzjI+BvvywsHVO+gp4BRt+Qu/
 fm6H4vo8+AEYssQvzuC9LcUYm7WX6K4T9zCJmZmdirvvZgpNS/8IVQQ1kE+wrkq7ZOAt65W4ohX
 KatB92QEydWWqh16bZ
X-Received: by 2002:a05:600c:4752:b0:4a3:59c9:a754 with SMTP id
 5b1f17b1804b1-4bb55ab2b89mr209922355e9.22.1794822660703; 
 Mon, 16 Nov 2026 01:51:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2842e6sm384527605e9.4.2026.11.16.01.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:51:00 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:51:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I793327150883ea0207bcb9724341e750bab92474
X-Gerrit-Change-Number: 2179
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2179?usp=email>
X-Gerrit-Commit: b94220584e03a56507d568c6030e31b360322cfe
In-Reply-To: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
References: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2Njg3MDAwLkk3OTMzMjcxNTA4ODNlYTAyMDdiY2I5NzI0MzQxZTc1MGJhYjkyNDc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5232ca3bbf45bb6cd5d8d23bfaa7ec1d8fb30711-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xStMh-000000002Gh-1Z1F
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: wipe and
 free partial responses on conversation failure
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
Content-Type: multipart/mixed; boundary="===============8425008643115312310=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8425008643115312310==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cqe+RGUr86c="; charset=UTF-8

--Cqe+RGUr86c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2179?usp=3Demail )

Change subject: auth-pam: wipe and free par=
tial responses on conversation failure
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

auth-pam: wipe and free partial responses on conv=
ersation failure

When a later message failed, my_conv() freed the response=
 array but
not the responses already filled in, leaking copies of the passw=
ord,
username or OTP without wiping them=2E

Change-Id: I793327150883ea0207=
bcb9724341e750bab92474
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eor=
g>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179
Message-Id: <20261112141839=2E514=
7-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg41194=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/plugins/auth-pam/auth-pam=2Ec
1 file c=
hanged, 8 insertions(+), 0 deletions(-)




diff --git a/src/plugins/auth-p=
am/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 72c047d=2E=2E16fd=
2a1 100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/plugins/auth-p=
am/auth-pam=2Ec
@@ -789,6 +789,14 @@
     }
     else
     {
+        for (=
int i =3D 0; i < num_msg; ++i)
+        {
+            if (aresp[i]=2Eresp)=

+            {
+                plugin_secure_memzero(aresp[i]=2Eresp, str=
len(aresp[i]=2Eresp));
+                free(aresp[i]=2Eresp);
+           =
 }
+        }
         free(aresp);
     }
 

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I793327150883ea0207bcb9724341e750bab92474
Gerrit-=
Change-Number: 2179
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Cqe+RGUr86c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2179?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">auth-pam: wipe and free partial re=
sponses on conversation failure<br><br>When a later message failed, my_conv=
() freed the response array but<br>not the responses already filled in, lea=
king copies of the password,<br>username or OTP without wiping them=2E<br><=
br>Change-Id: I793327150883ea0207bcb9724341e750bab92474<br>Signed-off-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2179<br>Message-Id: &lt;20261112141839=2E5147-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg41194=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/plugins/auth-pam/auth-pam=2Ec<br=
>1 file changed, 8 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec=
</span><br><span>index 72c047d=2E=2E16fd2a1 100644</span><br><span>--- a/sr=
c/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/=
auth-pam=2Ec</span><br><span>@@ -789,6 +789,14 @@</span><br><span>     }</s=
pan><br><span>     else</span><br><span>     {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; num_msg; ++i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (aresp[i]=2Eresp=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                plugin_s=
ecure_memzero(aresp[i]=2Eresp, strlen(aresp[i]=2Eresp));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                free(aresp[i]=2Eresp);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
>         free(aresp);</span><br><span>     }</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail=
">change 2179</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
179?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I793327150883ea0207bcb9724341e750bab92474 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2179 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--Cqe+RGUr86c=--


--===============8425008643115312310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8425008643115312310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8425008643115312310==--


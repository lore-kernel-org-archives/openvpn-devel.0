Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5C606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RYM7TGk5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XUbhxIXn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L03aRpLw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ToqgL+ro
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=72HaZflKe4GX1VFNELV/sYbZHtZkz4rhU9oVDY6L2w0=; b=RYM7TGk5qMVU8l3OBlgs+XgrKO
	NWfDANXZ9HIt/ES5XTI7HS2xkhdV3w/eGZWHXDBmd/FItCqglu5DZdeLicWnHY2HMBIkmnmFim5Ga
	kV+qAJleou8u+2PZCLJ5/iGU0oWBG2xmR9D0uaKcFCxZVufpROJGR7R/aRgWXDpDhBAI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUggv-000000002Po-40ed;
	Sat, 21 Nov 2026 08:43:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUggv-000000002PS-096J
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 08:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CbN2s+4ZtzqPsSGy4e2GuEYpfi0HmStxISDXnWhHvE=; b=XUbhxIXnS9AcC8gY4eWlS4Fm0D
 GkbRZ9VFcruf+gi6SVt2Ef8yEldx+viM72W0UiRJIY7frZP+hG0e47ppj0UpLNIbSncfXlQIjJ6NK
 Gd6A8zrc+07C5XVnFItK5aR5NSiRd0mkSEmqTXrBSELn2iamCZYVI57Bxnf5Ro5Vh2BM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CbN2s+4ZtzqPsSGy4e2GuEYpfi0HmStxISDXnWhHvE=; b=L03aRpLwZj4WJe/URHAHGp0aWT
 xfE2EDjTVJmbB1PTd5Cq7EVlpxMvlp8hKCj44ZkL2sunDFDcNq7KVHUyV/JdxER65hFptUX6ACntG
 Ak6FCeYTyA4yqgbE8KK52gibmhrDC8NB7S5CpKUVFCG3cFS72YNqhkAjJcXh88VD4Nko=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUggu-000000005F8-08C0 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 08:43:24 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so16312365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 00:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795250597; x=1795855397; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/CbN2s+4ZtzqPsSGy4e2GuEYpfi0HmStxISDXnWhHvE=;
 b=ToqgL+roJMBXOys34y1HdHjnnTKlBHzJ+OwzqOTtql7wvJJfBvM014YVWcvnkY0sVK
 WTJ0x5TJOZEz3spCLkyxxKZLEGcZxGJKEvVQvDuCi+97GXWxc75eKK3lvj/AqB88vrBp
 z4rJtxpk87ZBBgLzaboomz1YYk6PAn/yCtzTHJOjLARJ23AXkkmg/jnalVyrSb2LbLNX
 1sHvr+SGVNLe1aG8Fk19gfN9SY+E7wlyUbswMz6Tkr/RQbLRZ8HXczYlqwop5RsaXPTB
 X2QAw6r/aqd7bdMkT3w59mkVuSCKqldvdiI1uiqv8aaz+EDRUW6T2IxK1fBG6r6yXAB5
 7heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795250597; x=1795855397;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/CbN2s+4ZtzqPsSGy4e2GuEYpfi0HmStxISDXnWhHvE=;
 b=BzVq3I3m8Yk/SkBV9AXzUx8tdR0vBaaMgZ8XZoRUKVeUifNdq+Ps5fe6lWHKFE4GQc
 btjtOCvAxb3Ei3xs4bGX8hNpYQg87eXMO9CT0/J6At1aNfu08AY8K2bUB8uNfU9qKWfj
 drjt4DJP1CpSON48mtONWt2OFkGBqGEArUAxBKvHdHAEwYAhy33h+o5wkCbY1b+7/ddO
 KayUEyLoPe6QNfxTvl2ZdgJjoupmRsVYnxU8mtDVhAnCJTjT76zeMb5Ec+X9z5w8tt8H
 efEn7SEQmRXjkblyBvqc99qNTr61G0qAazlLN7aXND0iQPItIGb5ViUTHCS5Gzkf6oNj
 Pd0Q==
X-Gm-Message-State: APuU4Z/JO6/jNlF7i1bVvuotXegES4VbsMJ12or1GpALf+D0VObWNmE7
 5LM34mFu1L7OHSbFKLe1mcN2Mhu7hEi7ePS7GAsgRxetV5XY/kKeLFk2aKW1L20BOCfd8RUThFo
 EG4U+NAV1Miv/0xJ9ppOPxmLEwfns/33mh7kCGlw6rZRRJVjUg+Y9qHg33QPsXsMEWg10LuyWIe
 CNT6UpFA==
X-Gm-Gg: AZFdTZcgjG0NMpyt9vPTNNVKilYrv3lEVcvG26FgMYq9h9CK6763QtTnBE5xrVhn2i3
 kqWy+LbNCccIjqwRSOjHx6NMfcl5ldsOagJtrFXix4r3TpkhQCEF+brL56Yo1/g01XQckm5Ay3z
 QJbpQtyCB9Q+wDtnnPXJbeaZR8dUKSM9eCgz5kJBd8HbHcEI1xR+5du2S1kVmfqfnlfBk2vU9Sw
 6O79ajbZTnwsiasTGQb5ekxu3cwecvVk8FGOxSornaTlcO4s6BRh7+EPjZgOKBUT658Qvy5Phov
 f6tpsqgiTlKPs5l2yV+Z/dGjl74+hX2O2Cr1M7Q2pKFFKBwq6trcBcpJSynrfYWLX71lhpEn4FF
 HR2uCR0eIKbe8fCkbHBS1zHLYqTu7NYfegbmu9vFnh9QVFV0H2za37hY2lkR4cNZMiVTY0i2TwF
 7+1JPIQ9Vxq8Mb8B10ilH60Wg4LcfyX2/q32kq/fPzrxCO7Mp2CedbTXjh+9pvk6h/R7M7y5SyM
 Shu9sFOsLf15E7Sif65WZZwPZcxbBApYB+Xd8O8Pk5kaZ815sgqh5cWg0S4XdscjrkuVHf4w/Tp
 WGAPn0doB2VtEXvgr1r0vkR2R2h1Odh/s+604GOiGUlLWXXSjrPlQuZvOCjZo540AMKBRbm3Seh
 qtsr/H/kS9VN33S1tcbxcba4959t9aJNUAoCo6haCpluUVqlXy3UDfZZFxOw/h5QdK4RM8kNMJM
 sXl8BYtPbJm1dGon8=
X-Received: by 2002:a05:600c:530e:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4bb887fe8f1mr126927035e9.10.1795250597243; 
 Sat, 21 Nov 2026 00:43:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm10010809f8f.41.2026.11.21.00.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 00:43:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 08:43:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
X-Gerrit-Change-Number: 2237
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2237?usp=email>
X-Gerrit-Commit: 860f760f1962644034e176ca1f0fc743c89a2a0b
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjUwNTk0MDAwLkk0OGQzMTVhMzhhNjUzYWVkNGIzM2QzMjc3NDMzY2I4YTY1OTY5NDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2828480e802216e4bec4a271236d441041aa0df6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUggu-000000005F8-08C0
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: free
 ext_cert_input in man_connection_close()
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
Content-Type: multipart/mixed; boundary="===============5642913162158744447=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5642913162158744447==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="31x1QMsCkVQ="; charset=UTF-8

--31x1QMsCkVQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2237?usp=3Demail

to review the following change=2E
=


Change subject: manage: free ext_cert_input in man_connection_close()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: free ext=
_cert_input in man_connection_close()

ext_key_input was freed there, its c=
ertificate counterpart was not=2E

Change-Id: I48d315a38a653aed4b33d3277433=
cb8a6596942d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M s=
rc/openvpn/manage=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)



  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2237/1

=
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 86c498e=
=2E=2E470e989 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -2862,6 +2862,7 @@
 
     in_extra_reset(&man->connection, IER_RESE=
T);
     buffer_list_free(mc->ext_key_input);
+    buffer_list_free(mc->ext=
_cert_input);
     man_connection_clear(mc);
 }
 

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
=
Gerrit-Change-Number: 2237
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--31x1QMsCkVQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: free ext_cert_input in man_connection_close()<b=
r><br>ext_key_input was freed there, its certificate counterpart was not=2E=
<br><br>Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d<br>Signed-off-=
by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/m=
anage=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/37/2237/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec</span><br><span>index 86c498e=2E=2E470e989 100644</span><br><span>---=
 a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</spa=
n><br><span>@@ -2862,6 +2862,7 @@</span><br><span> </span><br><span>     in=
_extra_reset(&amp;man-&gt;connection, IER_RESET);</span><br><span>     buff=
er_list_free(mc-&gt;ext_key_input);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    buffer_list_free(mc-&gt;ext_cert_input);</span><br><spa=
n>     man_connection_clear(mc);</span><br><span> }</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=
=3Demail">change 2237</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2237?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2237 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--31x1QMsCkVQ=--


--===============5642913162158744447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5642913162158744447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5642913162158744447==--


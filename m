Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8B606A336
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JSmNUF8s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dIIXqCAv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HjYUy1J7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SkMU7Jie
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=KIGDfXVrf4GzB5p1PYq94LcOqUuK9/zx6hYZlMDPJO4=; b=JSmNUF8sL5K00ioTw3/PprrLIP
	ea6yDg46RPlwr+3BJzb7vwnSUIKBYtj226vkAiVB5aJO44/I34+UQtkfz8wSEhHFcz9cYbRROhj3y
	kf4IKiCfWkd4AueSFKaHU+fkhoEPScVtbqlL1xCMPBC5Ly9LtFilvXQFqIolumt6xJUg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPDj0-000000005tr-0YhF;
	Fri, 06 Nov 2026 06:46:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPDiy-000000005tj-2lPS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 06:46:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1hbcn1IGlyIX9v4XMCknBUMUnRms6rS0ZsFEbsxvBEk=; b=dIIXqCAvXdg7ilVFswHpLfv4JF
 QOos2EHE0sRpJc30czCUJOhF3+fXmR7BGUIx0n4Dj/nDdo1xHMBV2XSfUfdszIhGwGOwLVV3qPx+P
 xEk/a/YrmF6wLcNz3tu8WaGEaFyqF25nsqDKLpfNJMSBbaV8eBvTszGlMGWz43TGFEno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1hbcn1IGlyIX9v4XMCknBUMUnRms6rS0ZsFEbsxvBEk=; b=HjYUy1J7FN2bV46M8uKKkmHTRN
 rIq5vSpruWJbr7iylfFlcBrcNPpfv8vlNwyNOE7vSI0dOj+/8fg4VPVMal7PuNIe/1I7sqHgDppp8
 cp2RG8KBiHrVwKUaFIzfSYlQzdDChbkK8N6iqczOv05CcZyQ6sdO/dWnCQMTB/RvpIvo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPDiy-000000002ML-069J for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 06:46:56 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso2367885e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 22:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793947609; x=1794552409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1hbcn1IGlyIX9v4XMCknBUMUnRms6rS0ZsFEbsxvBEk=;
 b=SkMU7JieN7kF+Lihc/HY9Xic6fucQxl+P12qlgytoW75M6vsqky6c3JHz1GBCiNKG4
 r0TQFfuPKPbzLZgEZWh1nvrzCrS2vz77NxNHxs96dd+0DOmdILL8oX9VxNWBhXAf9lXa
 4q7epAOiCgK8oO11r9MrJz8lAyqbf+tpRqyxdW2NJgplSDUybeotWDEbQXdRwbGmiLO5
 rs6yxhPHHPDIdqvDQU0D1gal4lcK0C819xKa9tHJuoHrd3kd5vS5nalpK7e3RnZ06VSu
 GAe6FU1khKu61lQWGCr+MiCW9SUFWzyTjwNJO8yHkcis8nuoo0qY6lWJYB4njtXhXJ87
 vy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793947609; x=1794552409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1hbcn1IGlyIX9v4XMCknBUMUnRms6rS0ZsFEbsxvBEk=;
 b=DCE2ojIY+iI4sK+LguTQyShTt8mP3kZh3FeSFCMOmMCb4qc6BnWE/W0HSJPcgaDaMR
 dsJODXBy1ol7rRSDCT15Jp7RN3wyRD0SGmIU67J1us2nKplbmSCmV+oQyXW9CuzShrAs
 1Kxb3K+Fjxs75umHMyml3TjUaf9V2UyfI+oj6bJ9puoIHAn7GmOa+iU+oDEr4GQ3mzow
 aUZSMlYUND2x8bB+4onrAVadm5ebsnmkeVq+vBhZtU6bytxB3gDtjviwsKpwdIZ4doJ0
 CxbfDtypCQHl6ClDQ51KuYSVz2C13dNce9qD4S+vuBF65WzKvcnLUuWKyQPI18rSiTuF
 vMkA==
X-Gm-Message-State: APuU4Z9d74AwFB0IfFGo+4KxqvfGLMUVOQYHFKZ/l/zR7SnhfA1R+OZn
 abF+La+x90Ss8MYSc3+z9YqSGZFGrOeC8C3bsNljvtevn/URm8ZiYRVDCmXJo0f22uPTXiorWDO
 hYJhtXAI4gZ/l7dLloy4wHDqJQ9BKhQsHdeZ80EMt1VhJ5OcLBfFHzwFZB87k1Bapl9EYRtXX1f
 4uOApP5w==
X-Gm-Gg: AYBFou3QwhUvIoA0WWtmFBGDcnRxK4iuuIhlk2bEcy/jkofwnLITYfrDNurdCUSIWRy
 p3y5+Zs2t4K8XbDlzP/A9ZIH9Y2cD4gj7HL8QbcUDPnl2ea3vktJprVRY4lhAq7vRP5nPZDBAB0
 jzOymrSBjx240CDT+wVqPNvRYw0tFaSKr44rvR1FN/ZNIp3WIRNUiwQjPle4TGLKp5fK2n6tvn9
 4wVvT/E/wbaFjuSzitr2Th4eYNXhYW2UG+SSXfgBJtdOTiNke9LQUvf9nTScPMfNoIoVOHUqOXY
 SKSeQgtqTJXjiKOMd7d6oPvCp9MZq0TsLz2dJhuls2DiFsSxZuDefZRSfNztoU6qQUWRsJtKeBX
 s9TLGeE8ObXo0Pgyb7Ui8UhVEyAMY1NjqHll1EFr7EsvbSSq0TNKmLVhiwcTJdXldV+JgQ1h5cp
 iwII1J/CkXgm0wzRoH1DTJmKzXkEl4vEvlbp06V6a7yVbGcShDtnIuK2jcFMe8D60sl3lEqo5y3
 P8A2vpTp4mwQQpQw1JRxfzcJeb9NTZaERoG2Chwqw5SIpXP3QjmrAhjie+tM/kryzRrEj4kgX9U
 FLOj1xbXVtrhvmv+OHc1ugmKYF9Mvclla4iDb8sTwiLL1rVaVHDFCbRLzkaxn5BYyxuLMOJGY9e
 Lg7R319TidFZ182c/r/JZo4ACXnuE7UgJk2R7OGQ3a5NjXng5fNGDXk6g0ds1Z8vfKbrbmD6thk
 2/1mxVYzIqycj+6Q==
X-Received: by 2002:a05:600c:a015:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4b6df028f04mr21894835e9.14.1793947609364; 
 Thu, 05 Nov 2026 22:46:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46489sm112489795e9.3.2026.11.05.22.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:46:49 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 06:46:48 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc
X-Gerrit-Change-Number: 2142
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2142?usp=email>
X-Gerrit-Commit: 6422a369d480b3f6f3a99471b8a1b81a7189dc97
References: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTQ3NjA3MDAwLkk3ODRmM2ZmZTE3ZWNhZGFiZjk2Y2FhZDExZmU5Zjc3NGFhMDBiN2NjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c0a8ba5123f01182cb613daebab2c7d638f54a5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPDiy-000000002ML-069J
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: comp: use the wire
 byte when escaping v2 uncompressed packets
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
Content-Type: multipart/mixed; boundary="===============1727008879483737357=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1727008879483737357==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KlkTyHkNekk="; charset=UTF-8

--KlkTyHkNekk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2142?usp=3Demail

to review the following change=2E
=


Change subject: comp: use the wire byte when escaping v2 uncompressed pac=
kets
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

comp: u=
se the wire byte when escaping v2 uncompressed packets

compv2_escape_data_=
ifneeded() wrote COMP_ALGV2_UNCOMPRESSED (the
algorithm id, 10) instead of =
COMP_ALGV2_UNCOMPRESSED_BYTE (0) after
the 0x50 indicator=2E Receivers reje=
ct that header, so packets whose
first byte is 0x50 were dropped with stub-=
v2 and lz4-v2, e=2Eg=2E tap
frames to a MAC address starting with 0x50=2E

=
Broken since a75bb2e4 ("Implement the compression V2 data format for
stub a=
nd lz4=2E")=2E

Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/comp=2Ec=

1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/2142/1

diff --git a/src/ope=
nvpn/comp=2Ec b/src/openvpn/comp=2Ec
index 387a7c4=2E=2E513a766 100644
--- =
a/src/openvpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
@@ -100,7 +100,7 @@
 
   =
  head =3D BPTR(buf);
     head[0] =3D COMP_ALGV2_INDICATOR_BYTE;
-    head=
[1] =3D COMP_ALGV2_UNCOMPRESSED;
+    head[1] =3D COMP_ALGV2_UNCOMPRESSED_B=
YTE;
 }
 
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2142?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I784f=
3ffe17ecadabf96caad11fe9f774aa00b7cc
Gerrit-Change-Number: 2142
Gerrit-Patc=
hSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>

--KlkTyHkNekk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">comp: use the wire byte when escaping v2 uncompressed p=
ackets<br><br>compv2_escape_data_ifneeded() wrote COMP_ALGV2_UNCOMPRESSED (=
the<br>algorithm id, 10) instead of COMP_ALGV2_UNCOMPRESSED_BYTE (0) after<=
br>the 0x50 indicator=2E Receivers reject that header, so packets whose<br>=
first byte is 0x50 were dropped with stub-v2 and lz4-v2, e=2Eg=2E tap<br>fr=
ames to a MAC address starting with 0x50=2E<br><br>Broken since a75bb2e4 (&=
quot;Implement the compression V2 data format for<br>stub and lz4=2E&quot;)=
=2E<br><br>Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvp=
n/comp=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/42/2142/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2E=
c</span><br><span>index 387a7c4=2E=2E513a766 100644</span><br><span>--- a/s=
rc/openvpn/comp=2Ec</span><br><span>+++ b/src/openvpn/comp=2Ec</span><br><s=
pan>@@ -100,7 +100,7 @@</span><br><span> </span><br><span>     head =3D BPT=
R(buf);</span><br><span>     head[0] =3D COMP_ALGV2_INDICATOR_BYTE;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    head[1] =3D COMP_ALGV2_UN=
COMPRESSED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    head=
[1] =3D COMP_ALGV2_UNCOMPRESSED_BYTE;</span><br><span> }</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?=
usp=3Demail">change 2142</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2142?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2142 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--KlkTyHkNekk=--


--===============1727008879483737357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1727008879483737357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1727008879483737357==--


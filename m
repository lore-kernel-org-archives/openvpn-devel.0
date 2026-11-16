Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF98606A336
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C685i1S7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ankI1I9b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fzAdqzWm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CARNVkYW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=c34nFwHI4ZrQFVwwYh29gG9nXFqQBWZllLpP3Pn/HG8=; b=C685i1S7xIcGIwiEy7fnKL1667
	JREioqAfzc7lnNgiPBEFthJx3W7uLldYABRxALxKJI5aay9YwwoTr7iI8EgrqTaVO851FGZj+D+ae
	UGw60JqIhLBNZgG/SIZ0igOyzsYU9O8QYP8jJdBTbAd9utjJzNevO50blogpuXzAYBSs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSw40-000000002Wo-2SIq;
	Mon, 16 Nov 2026 12:44:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSw3z-000000002Wi-3Xg9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NoZh4FAuVc7r+TvWzdiLGp3iWIvDeFWM/Q6AyFM5SYc=; b=ankI1I9bFpzieNbFIVKWaj3V1w
 8z7V0m9ilsIJYRuriacpYVqRR4RF19DfY8wm/XzaVdsxhmHJqkuU0D/qGhryH8u1nBacJvUCq96no
 lHzHWVk54EOaeH7TD4QiSAATnhTQQl8qcaqDCnglRlD11z1WcMbO9HYAawwRDYlEy1v0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NoZh4FAuVc7r+TvWzdiLGp3iWIvDeFWM/Q6AyFM5SYc=; b=fzAdqzWmZ5HFkwMKhLq/4iVqwh
 mRMHlHkrNQC+5TSMD03dN3u0NtwwfVIcOTnDnwwYKqTDrm7xc48wupBInqJE2FoFNYj3SL87WjOCm
 9Khl+wm+UiSkUl+Xjz/zuDauXzWIJJCLZQglpMiONQIygNqdiYKWsV9EiLNNWTjyPOdM=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSw3z-000000003ss-0z00 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:43:59 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b7245ab5e2so6976596a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794833033; x=1795437833; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NoZh4FAuVc7r+TvWzdiLGp3iWIvDeFWM/Q6AyFM5SYc=;
 b=CARNVkYWLF+EXR31VZ61oaIG9UikysogmLcQ5sOvDvRzi+VnN2O5u48d+Oh4qv7b8C
 Zj0+EvcWkWB74bnZOZiRpfPMz+ntfDhiPn1lunZ774dIRF1nI/9nNByDELpZ0tSKdiwJ
 +Mow0SRcCFCJyiSqmemHwvBv0NzPeEGoo2wMGA3dKinISYj1umNNClWxLbTrYCQZ41Py
 BPy+vavt8xf8KY40w30iLJzZggw6dZdDW4qrpKYhE5DpWQK8Ymg5F8BNe3Mwr1p2Ceab
 GjktIXazBPhCXGKqOnhGlyqB2cUD0bMi3FU7WW164uIzl0wNDv+czRIsLoiCvrvyKsWq
 tfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794833033; x=1795437833;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NoZh4FAuVc7r+TvWzdiLGp3iWIvDeFWM/Q6AyFM5SYc=;
 b=JzAeJnfuF1p5WepT34Rv018ZYtop9qF+plpdiqliI9zxKIrDWLLNGgyqcbdxvPblkT
 br1UArxUsuD564Y3MJrIYbKuXQQH0Ye7DJecvfulB32eDxONlOUm2LI5v9pL1FWg4rqD
 8EC6v82p6errpXNHTMiSKgQXvbMpD5OTp9g1VOzx2sGY8Om26oEVwDMX0vREz3tmpaAg
 c4B+q+Ns6H1uNXNp4CPpmL3yPFrjFvgUraGiy5DryHaWKYWwem8czXfp6M8Wv7g7dEMH
 P5NZHJIf1S4agSZVirtMEisjPmCuGBsja436LHXWAALsWNQKQirkr3/CWg/hMu6I7X5F
 8d9w==
X-Gm-Message-State: APuU4Z8thB7A42MqKRRBSReYvnlhLaBcr4ZP5XFy5UZLnCUS3snO2QGd
 A7sS15ZRp9o4bHRzf7HiPGZ8fGxSlaQdYaxfsCsXPRsfcir8whs0ilToCGvfLZuLRO1lNzqFjZ5
 5kU2vZEvxhfH+j0RDplckQfU6PSvG3WyBSL3e3+hQAOHNd9LXXFuntu2pDXh/8cdkAIl5+v6GUS
 U/TjXVRg==
X-Gm-Gg: AYBFou0VEhjQJ6p1uHgHoPnKTgESqG50xmGfIDAXaS/owqs9RAYTYnDj57XOgtBeP4D
 E02Vdn6XZA5azUgxdnfb3Z2yIndP5lgbVVbSLG15r1oc0u+1OJ3C6hl/DmIAbHV+1LJFCqGyfb2
 wFbFNZyMLrf3DT4kdY/Jgh2Y8WfVG4XnzWp6+GzxmXJ8wpMwfWgCY3sm1boHVZWFicxqlaM9MtF
 UGnQMWzu0zaoipq0bCLVwB8SNyVDHhJaX8h2qKRdkk0CjaTDM/eW8u9uJQbjb3F/HdvV7tfUZGQ
 mrJwyZ8AEdCDe+BdYEWvrpc1Vgxq9ike8StnG3tN/wfgpG955jSmdb5eFNCsiqwJQNfbmYJ4k3x
 7LEByCaSHLCOL94TAOMkyqrB4a3MHDRguG9xb931O+PXoxkvy1dGUpyfH64akoDcnwgt5brsDcY
 jv16ttPePmHgvgFH6U+a1D8As5Y6/jSz6yQL2GUahbxsdv6+4zMY3dPZlF77fb+LSCZmsRN54Xc
 E39XSI/WsGL/hsniOmgdSe7CSncvG2lLtWnDB4a3NrdwKHmtQ+TuK1nszRIzjTiFxHs3YiQOxje
 9vjsGRLi2T6I1Px+REQIxmZkjvHo7IKiwWgnKeOTqqdpqaF1dw6l+Fu0vPllATtBRe5tLFkbgAx
 RvtCxrhaiNkyQ1++wuB8BU67yq33M1AXmleKRPSO7erwUMnNS9Mr1wNqhRxS4nuKljeRPu50vq5
 +4aZWxyibM3MIGLK/xobCdOEPvLzP3O81g9BSNag==
X-Received: by 2002:a05:6512:6192:b0:5bf:ce43:979b with SMTP id
 2adb3069b0e04-5c164e953bfmr4414960e87.21.1794832617715; 
 Mon, 16 Nov 2026 04:36:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c17134810csm3205056e87.50.2026.11.16.04.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:36:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:36:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f44
X-Gerrit-Change-Number: 2192
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2192?usp=email>
X-Gerrit-Commit: b7c57b8c107c08e7243dae9b11b817508a1d6bb2
References: <gerrit.1794832614000.Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f44@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyNjE0MDAwLkljM2UxM2U0MTRiM2M2NGNkYWZiNTdkY2ZlOWQzOTYxNTlmOGY1ZjQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d781ef78a0902b5216857c8733b2b01aeb04f721-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSw3z-000000003ss-0z00
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socks: convert
 service port to host byte order
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
Content-Type: multipart/mixed; boundary="===============5797581638279418595=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5797581638279418595==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BjEqqUOM/OA="; charset=UTF-8

--BjEqqUOM/OA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2192?usp=3Demail

to review the following change=2E
=


Change subject: socks: convert service port to host byte order
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socks: convert service=
 port to host byte order

getservbyname() returns s_port in network byte or=
der, but the caller
splits the port as a host-order value=2E On little-endi=
an hosts a remote
port given as a service name (e=2Eg=2E "https") was sent =
byte-swapped in the
SOCKS5 CONNECT request=2E

Change-Id: Ic3e13e414b3c64cd=
afb57dcfe9d396159f8f5f44
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
---
M src/openvpn/socks=2Ec
1 file changed, 1 insertion(+), 1 deletion=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/9=
2/2192/1

diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index =
51e3a1e=2E=2E5cd6d8b 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/s=
ocks=2Ec
@@ -332,7 +332,7 @@
     const struct servent *service =3D getserv=
byname(servname, NULL);
     if (service)
     {
-        return service->s=
_port;
+        return ntohs((uint16_t)service->s_port);
     }
 
     retu=
rn 0;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2192?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic3e13e414b=
3c64cdafb57dcfe9d396159f8f5f44
Gerrit-Change-Number: 2192
Gerrit-PatchSet: =
1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>

--BjEqqUOM/OA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2192?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">socks: convert service port to host byte order<br><br>g=
etservbyname() returns s_port in network byte order, but the caller<br>spli=
ts the port as a host-order value=2E On little-endian hosts a remote<br>por=
t given as a service name (e=2Eg=2E &quot;https&quot;) was sent byte-swappe=
d in the<br>SOCKS5 CONNECT request=2E<br><br>Change-Id: Ic3e13e414b3c64cdaf=
b57dcfe9d396159f8f5f44<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>---<br>M src/openvpn/socks=2Ec<br>1 file changed, 1 insertio=
n(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/92/2192/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index 51e3a1e=2E=2E5=
cd6d8b 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+=
++ b/src/openvpn/socks=2Ec</span><br><span>@@ -332,7 +332,7 @@</span><br><s=
pan>     const struct servent *service =3D getservbyname(servname, NULL);</=
span><br><span>     if (service)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return service-&gt;s_port;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return ntohs((uint=
16_t)service-&gt;s_port);</span><br><span>     }</span><br><span> </span><b=
r><span>     return 0;</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2192?usp=3Demail">change 2192</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2192?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic3e13e414b=
3c64cdafb57dcfe9d396159f8f5f44 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--BjEqqUOM/OA=--


--===============5797581638279418595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5797581638279418595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5797581638279418595==--


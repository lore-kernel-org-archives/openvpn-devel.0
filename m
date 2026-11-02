Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88F606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Yh5oqWYY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IXuDwjuX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bhXC9urI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TpPQ0PuE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MantqZJCA0aoOCjuB0VsAZsNJHzmkfelQe7DW47uF/8=; b=Yh5oqWYYDv1Y2qez/i/rU9o1L3
	b0OuCVDuzYwPidQLgOnjgTkF2JYKr1ioDedWd3r0sfhyeHkGcpsGxxaUwrSq2+pgrVP6i2XeDZfZH
	gigkUBhcv2Kwu/Zi6/MzSqHEVnqQvtrRBuaxFV9HJ5p1mASL7Veva1WDpXlT5SjcGor8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzel-000000000qy-3Vae;
	Mon, 02 Nov 2026 21:33:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzel-000000000qs-1XgY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vNyGEm3GOjI/85Xe931iwTUK9fPUKxTSzUc4xn52MdU=; b=IXuDwjuXw1MigSyh4ILBqRB6DK
 x8uiqXRcXXAKj0vQHx4SXq/5t2ixqfQ5JugLSRfq2ebiACm+OMp2YeVSKOe5/a0g4p+C7k2YxIWJq
 Ev3b8ErO3tdAlwQbLRKVRB0w4TTuxXI9Vn2bin7QQuFyeHwvjm0Fp17Bd7aESL2vi+A4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vNyGEm3GOjI/85Xe931iwTUK9fPUKxTSzUc4xn52MdU=; b=bhXC9urI0V6rkwbHfHthxAInvo
 umFYNTxXR6tLarC4OZm3y+gtcZosKWGAeXf71QszvJwMrRd4XuSeod8xBo8TzIrWxEx7OdCJ3ingA
 TnXbA4qjXEV6hhtKeR02NkLfyNORhURB3rsqMPTgq9mN1g6IvvnDsNS4Kq0jp+Flz/cs=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzej-0000000061r-2IcW for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:33:31 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e47347279so2171104f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793655203; x=1794260003; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vNyGEm3GOjI/85Xe931iwTUK9fPUKxTSzUc4xn52MdU=;
 b=TpPQ0PuE1uk6tFNCp53/+NmgwJnjSyZodH4LqRz5eeXs9E1WuzWm/UpiF29jANd8aX
 8Yzn2DJE1EQDttpdhvS+zyKNGlsBC6nSUpeIax629UFK/oFNKmhlj6A1HhsuOjP/h4DQ
 98b3Q3l8AWK9Dek81A4S8rVE6rCRPKNmG5uNRBMmFmqSkfQ2PsfB+Oc8+5Z9eTi0HWmQ
 6X5dvylEt/sszaYqCRbzxwUAOGDSKTQnrEbqJdAG33Vc/hKifxLFvBto/dHy/UGl9nV6
 Qvl2T+wDRZJh2wxVlzzXFVuidq8/1kuLTSj7ddLJUUadbtAG1WGLN4DC+Qh9lW9dDu18
 GC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793655203; x=1794260003;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vNyGEm3GOjI/85Xe931iwTUK9fPUKxTSzUc4xn52MdU=;
 b=Fc0BusasNM1GvjuHKQ0f4coSwn7Td9t+SkT1RjUiWwzImT0K+W+E1/5OKEcdfdEEog
 OuJlamlKw+FmixBhjVCYZj4fDgOzTjgctW1tfVliSnL94i5LW8OLvBs9CXC04fGK5q+s
 AM5uO6F8+XshzojWbn4/elpP0RdAxbuOTnNy3IGLHK2QOzys2LohGYTwrbJyLtrsIuLB
 eN1vqkhQryCOTRhJ6+q5utSpRwz4xbl0Bd+6ux436HdiPro6v+8Px33yfyaf7cbIRPH1
 VG1uaRbZFgVhS+0Q1QG4NlA8jFhjLAJkT9YcbcU2K3zOjTQT1840LXyEYBQ/kLxf8yIB
 Ufeg==
X-Gm-Message-State: APuU4Z+TztZ9BGNHzy8bChud/ixtmGzvtMOhkXWOZSVKqrRdCjhiQgG3
 VpaW1+881qehr+GQezVujDHdLuSzIJ4WJV/E55s6J/QZoNpq7K3wnh59kCHNP12VjpbP9aWeCEZ
 oraa3IUIQbGzoQ7EmJ4iYufOQ+yd1FmfQwx5z9DvLPhFQx57Vf0LJVrYGCDPYHELMOUOe
X-Gm-Gg: AYBFou0ygmszBgi+QoSmcwW6sr4Nj9ramXn3g9zM3XGyblAa9vxoY1pBy9J+ZaHc2AX
 gt6uD9eWlziIAc6ImN9dQoC8qjIrn6dUXaxhMssdF15jCAdwPYrK8vIFtIE+WN75HBh9ZKWpHXm
 TIpvLJb8OYc1/YpA0jLBAJoWZLIo92zIsalywppjwpajW19Aqd9X0NDKmbI2bjBZ43sIyQacUU3
 MP9StTS8H6iDB1QDBZbVB3o0w+qBQdtnamyushrNgsszSdOQ51L2nnQUpAjF7lsWoNcyb58Z42K
 qBYjJsvud/Rqs242gYrUNYNxeu5XpmN5HwTJw77e0uBwnKTzKaW07wxFERKsVxv6xsRPNyoy4Te
 PLUO434T3B/8MJ1xVu15HcEDIpj8NiJWIUwF4Ht5dF21RjQIYJnFwPh9UlI6jXepl82vvCXrSH2
 XbPOvw2qvAhXM06w1jLSk00G+3k+AcMjDwh9sBKrH8wRjfpM/4ylCVu04vBWszeDjPrWZdS6BXE
 KrCKaGj6bibKs3zvWdptwneeEQmwRBhOoz/a6sks2Op2h0YUDp66LgMh1z5x0eWvsNc0wRutXd8
 8M761mmvXYJjzkBrpHZfl/cOyYi9eFpTD7NLLkCLus/9gtWLUxO8GXo5c828fTpUB83ZaDGpcYL
 Evz9m8UuQAcb10lwJzp8CgXbrbQo3hzRGmWd5fS8PDXl6rz6D/0cmF0Hd4zjml3MrePWVpPEeFS
 wQbdAlRRasOr7azw==
X-Received: by 2002:a05:6000:2610:b0:48d:ee59:3a30 with SMTP id
 ffacd0b85a97d-48e6e303b07mr26577126f8f.22.1793655202394; 
 Mon, 02 Nov 2026 13:33:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm24540570f8f.6.2026.11.02.13.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:33:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:33:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9
X-Gerrit-Change-Number: 2093
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2093?usp=email>
X-Gerrit-Commit: e9ecd3c6ded76c03b9d74c1b37c87a07b54e10e6
In-Reply-To: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
References: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM2ODg0MDAwLklhMDMwNGU1ZWY1ZjhhNTUzMjYyYTMyZDc4ZWQyMTU3Nzk3M2VlMmU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4cf96887aa1e32a37bdc483f1ee858a40345c799-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzej-0000000061r-2IcW
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: close socket
 in Haiku get_default_gateway()
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5609102225685364888=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5609102225685364888==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ygWg7BNEZwU="; charset=UTF-8

--ygWg7BNEZwU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2093?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: route: close socket =
in Haiku get_default_gateway()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

route: close socket in Haiku get_default_gateway()

The=
 socket used for the routing table ioctls was never closed=2E Close
it on t=
he early returns and right after the last ioctl=2E

Broken since 7da14925 (=
"Haiku: Add calls to manage routing table")=2E

Change-Id: Ia0304e5ef5f8a55=
3262a32d78ed21577973ee2e9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093
Message-Id: <20261102165927=
=2E110589-1-frank@lichtenheld=2Ecom>
URL: https://lore=2Ekernel=2Eorg/openv=
pn-devel/20261102165927=2E110589-1-frank@lichtenheld=2Ecom
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file ch=
anged, 5 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/93/2093/2

diff --git a/src/openvpn/route=
=2Ec b/src/openvpn/route=2Ec
index 0bce966=2E=2Ee8de2d5 100644
--- a/src/op=
envpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -3719,12 +3719,14 @@
     if=
 (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0)
     {
  =
       msg(M_ERRNO, "%s: Error getting routing table size", __func__);
+   =
     close(sockfd);
         return;
     }
 
     uint32 size =3D (uint32)=
config=2Eifc_value;
     if (size =3D=3D 0)
     {
+        close(sockfd);
=
         return;
     }
 
@@ -3733,7 +3735,9 @@
 
     config=2Eifc_len =3D=
 size;
     config=2Eifc_buf =3D buffer;
-    if (ioctl(sockfd, SIOCGRTTABL=
E, &config, sizeof(struct ifconf)) < 0)
+    int ret =3D ioctl(sockfd, SIOC=
GRTTABLE, &config, sizeof(struct ifconf));
+    close(sockfd);
+    if (ret=
 < 0)
     {
         free(buffer);
         return;

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973e=
e2e9
Gerrit-Change-Number: 2093
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ygWg7BNEZwU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2093?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">route: close socket in Haiku get_default_gateway()<br><br>The socket us=
ed for the routing table ioctls was never closed=2E Close<br>it on the earl=
y returns and right after the last ioctl=2E<br><br>Broken since 7da14925 (&=
quot;Haiku: Add calls to manage routing table&quot;)=2E<br><br>Change-Id: I=
a0304e5ef5f8a553262a32d78ed21577973ee2e9<br>Signed-off-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2093<br>Message-Id: &lt;20261102165927=2E110589-1-frank@lichtenheld=2Ecom&=
gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261102165927=2E1105=
89-1-frank@lichtenheld=2Ecom<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, 5 ins=
ertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/2093/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 0bce966=
=2E=2Ee8de2d5 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br>=
<span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -3719,12 +3719,14 @@</=
span><br><span>     if (ioctl(sockfd, SIOCGRTSIZE, &amp;config, sizeof(stru=
ct ifconf)) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_E=
RRNO, &quot;%s: Error getting routing table size&quot;, __func__);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        close(sockfd);</span=
><br><span>         return;</span><br><span>     }</span><br><span> </span>=
<br><span>     uint32 size =3D (uint32)config=2Eifc_value;</span><br><span>=
     if (size =3D=3D 0)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        close(sockfd);</span><br><span>         =
return;</span><br><span>     }</span><br><span> </span><br><span>@@ -3733,7=
 +3735,9 @@</span><br><span> </span><br><span>     config=2Eifc_len =3D siz=
e;</span><br><span>     config=2Eifc_buf =3D buffer;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ioctl(sockfd, SIOCGRTTABLE, &amp;co=
nfig, sizeof(struct ifconf)) &lt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int ret =3D ioctl(sockfd, SIOCGRTTABLE, &amp;config, s=
izeof(struct ifconf));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    close(sockfd);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (ret &lt; 0)</span><br><span>     {</span><br><span>         free(=
buffer);</span><br><span>         return;</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?usp=3Demail">ch=
ange 2093</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2093 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 2 </div>
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
--ygWg7BNEZwU=--


--===============5609102225685364888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5609102225685364888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5609102225685364888==--


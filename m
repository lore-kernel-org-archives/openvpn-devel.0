Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2028606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bnl1I/YI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d2bsYDph;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aOF/VCdS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ow86oOAz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=sbTQy+ve9U7gE+tJlWC7TR3q8OT+JYg1Z5j/hWt7yPY=; b=bnl1I/YIHjdlGYoyC1SOh3oLzF
	9UpsRzGWZqky3qCcCWQikby/4Gt+sbDj2ra8fqPKP1zZ9aKr3eh50OpKzHtvTZPMm3l1ldMKE3Uo8
	OT4PCDqDcFPJazyXCZTkCqL9cHejP2KE3PAhg6HVbRcv2Ktj6mSi2mklPWNzIXwZs/ow=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUqo-000000004KH-22um;
	Mon, 23 Nov 2026 14:16:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVUqg-000000004IO-1pR9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cmvtzvVxqJJER9dwsCcmcbIByOn4NdZPrb2aDxqNYTo=; b=d2bsYDphpnNF7vIR4kg/KPhZMf
 LbrGLuEw8C40guSmRezmugEQhva7Tm6ysAK/b7oW+86UT34mzxJy3H3U5XzoTe97/U5FwIyJa0xyd
 bSCMgJy7nRzfC2Il5R9Xn+Ull4rwctg1WfGj7CBTiZwx0D+Jh1zYK7SH+C1sWmfs33qo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cmvtzvVxqJJER9dwsCcmcbIByOn4NdZPrb2aDxqNYTo=; b=aOF/VCdSveX3vAhG7Gm6ve4sWb
 Z4b7+NmevuUUzu6GKfQ7+Al/arui6LwMCkJ/Aspr1jnPVZM/Yi+MEbrD4lWyATi7bb0Bu60woYC/G
 S5TPCX3JWCJBgmcLAXy/yBNWiLsUWEiAV7W0RQmMBqyiE/rzCtlH41etL71005DCT0M8=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVUqe-000000004UF-49Zb for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:16:50 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so2017128f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795443402; x=1796048202; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cmvtzvVxqJJER9dwsCcmcbIByOn4NdZPrb2aDxqNYTo=;
 b=Ow86oOAz8TKVT3+UVkM/N4jxO9N+pQbPOCkmhKJrRb3jwvfbUwIKzmyPmZ5Tyb9IqJ
 Gci2Jd6eLA+KMUOW6/Cc2iunHCbgFlLPjYfAN+NCcDwjLAc65lZFsdd7qpHRe+xYGSRe
 IzRn3xRbPWwvtcpiY2pMoJ/OHv12na1hxlkOXXoXwchUPssTr3Miiu8RFwSNspsiXlB4
 MIXeLN0GV4QRdfc++t0FJemi3ONvqD10i0DhT5VRNh7wvaTWAD7rkrFoz91m0cjwx8ec
 aNrX3sBA+iq1zs99yOG8H/06A39itO/NI+Dn6L44sANC1lFwIqptnSM7PCLNa2XgU7w6
 KYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795443402; x=1796048202;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmvtzvVxqJJER9dwsCcmcbIByOn4NdZPrb2aDxqNYTo=;
 b=Xdu/1lHIUoNa1VqCG0aiX7RCXZxs2JzsDEFodVp26rCY4v0Zt9OiQFkv55PEi0Qs3h
 s8Dv5Cw7MwutIliJ9D+4H+7AqZndT8O/IpDZnv2IqtyClrp61yvP8lrzQFkLqUuQKpdS
 fFUZTdemmLHIudcomJuNlBJ/fg9I2+KnAcdkcxEdU4khgtevWV6g5pk6adn3vDo6UF9S
 0TuWUyT0ICV38+mmuPdTbzYWhTm9ZFCQz6hWbnXZvgdAmhEUJSTmeg30I++I4AA9dM+V
 ymnWxzpec0PIBPKuavfLPGJee0hzvtfvrCP2t/pWIJf1Mi0CKTmOTgm5mrAnZRkGJKQD
 8VqA==
X-Gm-Message-State: APuU4Z9OGsLfoDE4IjxxdIfimHFrAblOB2MlVwmexDbjPXvHTZO9cpVe
 92n9F1mCotP2csBsrXhEVzxXcbW9x/W4Eogo9bmTnd1TEfX0pbBnQUdr880Ggs0ZsIcipO77YAn
 iABloAzrd/GXozkDu0f93O4bhfzIysT8/jnHR+VA7uIenLwSBBLwYXBvpATzNzQTt4CVYlbfEFp
 Rjvq6vug==
X-Gm-Gg: AZFdTZdrdPk4fyEmw8GgfBXkTkgAicMNwLmkEKfjIvNk9XLxH0aLFZpSwBcqHonqvWK
 79k6qAm9x/l8ItI3FnDMeHsV5iPHj5UwaRNj2jEsp8kiC/1fDSE47lusMZDyiXAJ4zn4CTUULh9
 IRboHIPV5UP+Vs02RV1JaSetU/wm/SiYH/zs4c00IbdO2Dzx9ef95A7oJYJuNXaGQCfpqpQyfj7
 2bGd0XK+/WKXIa5MAy2Su9ldSCgHfaQVCOjHtEreXzkR28OKCFh7G5jaDY4NOFWdRM6F94f+Y2Z
 x39+S7Jokzomgpi+zO+ti/wX+kV0I7T2RIomQWC171Za1wF2W92TJzsoGLrg0ABTj0o79wARU5n
 jufTR8r+Gy8s0nQdK31xVtFdp21L807hi85PVCXyvjeiEDRgeDnxhSA2x2eg/IhTFuz4JuqkQGX
 y0YUW/7OXkaSmHVCB+POsCrZghg4thwlLj4CLanJfFAAqXQxaYfUUrYt8pww5NcYLFTq/rGszWU
 GUpz4DKteoncr0+EZWXiYLBUGhkGolOIvsP05YJh17duHt+d68+VMPvhEXhK4H9RRmwpdKZ5AA0
 iVbxjfqUd8iYgaHEu7mM45nrcmCd+h6sNAgWJuOyVcAyDB3jpKmq+Fa7+MxxbseAtxKOYUrb9KM
 1QYxuCn63FqBCLh7zvjf7eV7xmBS2M7Hy3q9jvtrCuVjtOnyJBQ5EZib66EMXqRhJecFAbEqYKI
 4bsRFjkS8hly/o2eXi
X-Received: by 2002:a05:600c:4e02:b0:4bb:5d39:95fa with SMTP id
 5b1f17b1804b1-4bb88811c82mr232411205e9.12.1795443402265; 
 Mon, 23 Nov 2026 06:16:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm355343745e9.3.2026.11.23.06.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:16:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 14:16:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb
X-Gerrit-Change-Number: 2329
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2329?usp=email>
X-Gerrit-Commit: ddb3ebcb8555ed31532915f0053c3826e93244be
References: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQzMzk5MDAwLkliYWI1ZTMyOWQzODY2NTFiYTBkZDBlMmY0ZjliYzYxYzM1N2NkZWJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <78d36c615fef2c4227e8cd3f2a41e0d18c67e78c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVUqe-000000004UF-49Zb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop unused
 is_ip_packet_valid()
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
Content-Type: multipart/mixed; boundary="===============1472579284086102144=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1472579284086102144==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5dDJj4E8UDA="; charset=UTF-8

--5dDJj4E8UDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2329?usp=3Demail

to review the following change=2E
=


Change subject: tun: drop unused is_ip_packet_valid()
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: drop unused is_ip_packet_v=
alid()

Its last caller went away with Wintun support in ad7a6945
("win: re=
move Wintun support")=2E

Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cd=
ebb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvp=
n/tun=2Eh
1 file changed, 0 insertions(+), 27 deletions(-)



  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/2329/1

diff --git=
 a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 61fe943=2E=2Ed8680c6 100=
644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -502,33 +502,6 @=
@
 int tun_write_win32(struct tuntap *tt, const struct buffer *buf);
 
 sta=
tic inline bool
-is_ip_packet_valid(const struct buffer *buf)
-{
-    const=
 struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)CBPTR(buf);
-
-=
    if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 4)
-    {
-        if (=
BLENZ(buf) < sizeof(struct openvpn_iphdr))
-        {
-            return f=
alse;
-        }
-    }
-    else if (OPENVPN_IPH_GET_VER(ih->version_len) =
=3D=3D 6)
-    {
-        if (BLENZ(buf) < sizeof(struct openvpn_ipv6hdr))
=
-        {
-            return false;
-        }
-    }
-    else
-    {
- =
       return false;
-    }
-
-    return true;
-}
-
-static inline bool
 t=
untap_is_dco_win(const struct tuntap *tt)
 {
     return tt && tt->backend_=
driver =3D=3D DRIVER_DCO;

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2329?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb
Gerrit-Change-Number: 23=
29
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--5dDJj4E8UDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tun: drop unused is_ip_packet_valid()<br><br>Its last c=
aller went away with Wintun support in ad7a6945<br>(&quot;win: remove Wintu=
n support&quot;)=2E<br><br>Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357c=
debb<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---=
<br>M src/openvpn/tun=2Eh<br>1 file changed, 0 insertions(+), 27 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/29/2329/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun=2Eh b/sr=
c/openvpn/tun=2Eh</span><br><span>index 61fe943=2E=2Ed8680c6 100644</span><=
br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=2E=
h</span><br><span>@@ -502,33 +502,6 @@</span><br><span> int tun_write_win32=
(struct tuntap *tt, const struct buffer *buf);</span><br><span> </span><br>=
<span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-is_ip_packet_valid(const struct buffer *buf)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *=
)CBPTR(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (OPENVPN_IPH_GET_VER(ih=
-&gt;version_len) =3D=3D 4)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (BLENZ(buf) &lt; sizeof(struct openvpn_iphdr))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return false;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else i=
f (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =3D=3D 6)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (BLENZ(buf) &lt; sizeof(struct openvpn_ipv6hdr))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return true;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool<=
/span><br><span> tuntap_is_dco_win(const struct tuntap *tt)</span><br><span=
> {</span><br><span>     return tt &amp;&amp; tt-&gt;backend_driver =3D=3D =
DRIVER_DCO;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2329?usp=3Demail">change 2329</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2329?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibab5e329d386651ba0d=
d0e2f4f9bc61c357cdebb </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2329 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--5dDJj4E8UDA=--


--===============1472579284086102144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1472579284086102144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1472579284086102144==--


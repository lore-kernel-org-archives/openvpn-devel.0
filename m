Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEBF606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WOZq1ZBR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ruf1AHZa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QYawqyiq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Uq2c8HAa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=SDIl8KPrppr2y5xoXZd6qI5ZhsleUmOVcTMYaWiUMJo=; b=WOZq1ZBRipdeywQBpK5scGPa+j
	TOI4Xbq50B1dhjZ2MS//xrlj3Bg15cV4c1J0G+UqKS9dH0LOGeCDfQaGe87ageYG4f/KQz9gAvFTo
	LRNVVUTdrpzGElXvtP0adcvmMZbVAmpgUrthWiGOl1XlnaSSeHekjEMTHygCOLkq5i0g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJS2-000000003RL-3Xla;
	Tue, 03 Nov 2026 18:41:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJS0-000000003RD-3AMN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:41:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sLsUQUCHqIQtN4nh5SYp6LjQfBxWxjRCdjk9t1NkejQ=; b=Ruf1AHZa8O6iRU6we29uZf3ngN
 04iadfgdyO5hz35tLoWtp9oAG8A4OWgwmk6LvMOEUMeMsUsCyL+Lp53CkiUzORPBXlZcKk84fGTUR
 bDo64DEXeXy3+Rkw8MsvXgpr/CL/UcRix2auedjbMCR47ECHuoFY2FoAwsd5k3FXqjN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sLsUQUCHqIQtN4nh5SYp6LjQfBxWxjRCdjk9t1NkejQ=; b=QYawqyiqteXwSQLoisGIF2GXfV
 UjJss/Z0P9QA65Bjc8ANJpsItL/P8gDTpOgEAPFP5rWdBjw+CNvnSQ9n9yOjXuuOM7n/ikVXcxQYl
 O9dxhcYozvfGluz0wEuU8yzCTG/gPi92TDbF3mGCGxAL/46ACn3HDZfDsBwOGeVBzWpQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJS0-000000003A9-0T5z for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:41:40 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48fbe12cfdcso148649f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 10:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793731293; x=1794336093; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sLsUQUCHqIQtN4nh5SYp6LjQfBxWxjRCdjk9t1NkejQ=;
 b=Uq2c8HAa0eb31RW107pfj8jhWV1XR6EnI8BgsK4VMfWpZRMrI5boKP1DU/s4VAtOEo
 UXlGr9KjiGkU1gZjr0jCVsFu4tGMTxgcUzti8eeOpcnJ8qlNDYhQ1uYhRsXh5kD5a4S3
 gQatyQSrpFNSwqYl30/zrIWuLUw9/Bc+lxAvYJMnrMYr/lmtXC40aPU5wNJR3yDofIC1
 l3NiQbqr0ZbwjLzAmfDdOPKV22QHbx2RCqK+9CGMBGkFCL6XKlFUHpspoRjFiGO6TdGR
 TND18K/z7ntc/Fe4+62Sv/kG+TIlXouoLR+mhL1lq4B6VR0WfuLDzOHuasCnqWk3rEFl
 4H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731293; x=1794336093;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sLsUQUCHqIQtN4nh5SYp6LjQfBxWxjRCdjk9t1NkejQ=;
 b=CYqmwOk7BVSNMJyngQBQ4sxi/sp8abwOzCLfuRrRodp5aVjzR//lMpqRpr4w7KNCnm
 yUX/vzYPBko8xo2urdoUiQ+KX4sqOwScpipP8wzyvA5Iw4dCGSCqGZzMqEq5pRT351ki
 0wQE+hqSRkNWVYt4Y/ZT/bpCrwvpxN590CsI/zOHgM5Llzbn53m8ezZTxDr2EhVU0mnV
 rFg80AmQkZh2AZiRu5pmyyhydLG9qMzzHiz+YoGf/4ZD1+msdhtxrSmSfG0bDLNSz5bL
 NeGAq474pO//aY9ZmhmTYEhlA1ZxznRck3ouWZLLxiYy99NySiu/6urDKPJWwotMIy9c
 J07w==
X-Gm-Message-State: APuU4Z+IOimYb25ENbuUbMoc4kJeFDKrCI+D8Yx9GnsvsvHsFgxjePld
 YXR20PcQYr7jprxSry4UhxohjTE1Rz5vkb4QAPI1pNTTjnAaXbW2lVxlY+nzphfKnHkI/wwvVzn
 Zx6n450TM40YGLyUBv1L4Ykgloyl0EfvCWZP17C8XGr3T4O005Aw+BY85noJ545kGbwll
X-Gm-Gg: AYBFou0rVYqEE9R9VOmNoENvfMcjuSRhXRtnG23o/ATLSN/AIXP5S2aByF51y3kGONC
 lUGScPmptmcV3QZFjieMlQY6+ddYsLoXeLhlEGF/sGRJUSx1RHZPUc3Nczj0RLuertFBUDFGcyj
 ROaSU2fpcz1F9Hyk3zIGRYdF5+LB7lm/TrIgkDcUCqLUBbr/oqIEziUP18AYt+oOPJ9i5jirqL5
 V2V3uyuOXZ9ScYtZCTWywAXjyQU/G7DaDQRHH+/qUGghtbRjICrUiXE2PFm3CEKER0jNVeCxYWl
 q2JKsUo57cTrwrpVWckFVm4LTvYeCr8kZAZc4jA4vq3OxiGiES4KZevA1GFAV+JDq2IvfEf5lz3
 0weMtm3/b38xUIuLGU/oOeAd0VT9imG14Ne+l3BO7rWmk70VkWnJ+6Xgo9m2zPYYZQZlAHqDMHF
 vO6NBoA4ALfKQpdEwzLKglqhwZ56HASEy8Le+Bol5ZC1cg+RFvoHDZJ+VNjXEy3noBXu07VI5JE
 Jvtxn+UPwsm40hCpO6U6HQ0IeDrpFJesz7sDzES253jSJsAuwA+mOyeRLPZPrvJA72h9fCZlfF7
 /jp5kBtgnSjrFoiCWfvTDZcs9F96C/6M19pEIKQXb20cX+Zeii+Kt/XvBcCZLLZBoyWIPUmesRh
 k4p00gzKtiIAdP9I7+0JqDy3fh+ODdxEofods72aW56TuDzQ8dHRHdNejS3s/c2JoVN8cjZZB5n
 /rYfE2qWV8HCqg1A==
X-Received: by 2002:a5d:6f08:0:b0:48d:f877:3349 with SMTP id
 ffacd0b85a97d-48e6e4f8cf7mr30044132f8f.42.1793731293247; 
 Tue, 03 Nov 2026 10:41:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fc9c760e4sm75190f8f.5.2026.11.03.10.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:41:32 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 18:41:32 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
X-Gerrit-Change-Number: 2109
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2109?usp=email>
X-Gerrit-Commit: f1d9c1a1758693bb5046219f356d753f5d094b94
References: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMxMjkxMDAwLkk5ZWI0Yjc0YjUzZDY4MGMxNjBiOGFjNjVhYjg0NGY2NDA0NDMxZTYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <770800b0f98798818cf55f99985fee8ca8d227a2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOJS0-000000003A9-0T5z
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: check
 DhcpNameServer lookup in GetItfDnsServersV4()
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
Content-Type: multipart/mixed; boundary="===============4380675821254704029=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4380675821254704029==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PeRXbpD3zr0="; charset=UTF-8

--PeRXbpD3zr0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2109?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: check DhcpNameServer lookup in GetItfDnsServ=
ersV4()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: check DhcpNameServer lookup in GetItfDnsServersV4()

The RegGetVal=
ueA() result for DhcpNameServer was discarded and the
error from the earlie=
r NameServer lookup was tested instead=2E With no
NameServer value, err was=
 still ERROR_FILE_NOT_FOUND, so the DHCP
fallback always failed=2E

Broken =
since 0f3b7d17 ("win: implement --dns option support with
NRPT")=2E

Change=
-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
1 file cha=
nged, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/09/2109/1

diff --git a/src/openvpnserv/inte=
ractive=2Ec b/src/openvpnserv/interactive=2Ec
index 484f27c=2E=2E4a8d0b5 10=
0644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactiv=
e=2Ec
@@ -2151,7 +2151,7 @@
     if (!strchr(addrs, '=2E') && IsDhcpEnabled=
(itf_key))
     {
         s =3D *size;
-        RegGetValueA(itf_key, NULL=
, "DhcpNameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
+        err =
=3D RegGetValueA(itf_key, NULL, "DhcpNameServer", RRF_RT_REG_SZ, NULL, (PBY=
TE)addrs, &s);
         if (err)
         {
             *size =3D 0;

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9eb4b74b53d680c160b8a=
c65ab844f6404431e62
Gerrit-Change-Number: 2109
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>

--PeRXbpD3zr0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: check DhcpNameServer lookup in GetItfDnsSe=
rversV4()<br><br>The RegGetValueA() result for DhcpNameServer was discarded=
 and the<br>error from the earlier NameServer lookup was tested instead=2E =
With no<br>NameServer value, err was still ERROR_FILE_NOT_FOUND, so the DHC=
P<br>fallback always failed=2E<br><br>Broken since 0f3b7d17 (&quot;win: imp=
lement --dns option support with<br>NRPT&quot;)=2E<br><br>Change-Id: I9eb4b=
74b53d680c160b8ac65ab844f6404431e62<br>Signed-off-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 f=
ile changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/2109/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interacti=
ve=2Ec</span><br><span>index 484f27c=2E=2E4a8d0b5 100644</span><br><span>--=
- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/i=
nteractive=2Ec</span><br><span>@@ -2151,7 +2151,7 @@</span><br><span>     i=
f (!strchr(addrs, &#39;=2E&#39;) &amp;&amp; IsDhcpEnabled(itf_key))</span><=
br><span>     {</span><br><span>         s =3D *size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        RegGetValueA(itf_key, NULL, &quot;D=
hcpNameServer&quot;, RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &amp;s);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        err =3D RegGetValueA(i=
tf_key, NULL, &quot;DhcpNameServer&quot;, RRF_RT_REG_SZ, NULL, (PBYTE)addrs=
, &amp;s);</span><br><span>         if (err)</span><br><span>         {</sp=
an><br><span>             *size =3D 0;</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail">chang=
e 2109</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2109 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--PeRXbpD3zr0=--


--===============4380675821254704029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4380675821254704029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4380675821254704029==--


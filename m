Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F914606D802
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EMh7v5rm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GKzEpsfo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kEqwV7e6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AS4FuYDN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=gQPF458WORRdz3m+QqRpTF4JZGNTx0ueBeo5UpBNGrg=; b=EMh7v5rmlwVbWhlDTnT/cMhVKD
	DpRv+C+naZ2K5N46R5hcK51JAM2Evl0u0jZeL9GCBYFv8XB/bxqQAWf4c5UOj5KyDVT7S5Qoeeabq
	9i0oG3Mm1nthuGOCPjtK92eumxX38HC9mTjNF0v9DmDUYFd2f3X4GaNVZT5oyP9CoQDM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9Vb-000000006ys-0x6h;
	Tue, 03 Nov 2026 08:04:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO9VN-000000006yP-3AzT
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hMvYawKfxpUVaxgAJIzapE8qjzSEX0I0KSp6mXM3mC0=; b=GKzEpsfoqWaK5HIKjY3GYlXjYJ
 3umm7ftbpkNiGXiJudmWhpHD3CF9J3WWZ4eXMNkw4vMgDgmi3wIv66Te3vvEeflJA5Aq950GHJVFC
 X8buxKR6DxTh1DYOOaKJ/4NQ5pHBWm0DSSwhXg2TtDwRmCC7qX796nh3jJ0u74IFoVzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hMvYawKfxpUVaxgAJIzapE8qjzSEX0I0KSp6mXM3mC0=; b=kEqwV7e65+s4GiwSaeYuixH6Qq
 9RGa8a+29340KGS74Vpep45I27e2d0mbjen1NsrQBlah/DRs0dIfGVjyBA9G7L1vHRjOfx4+IxuY/
 lFuCsVsnkcQQcic35TK1lSaFgRiyAnNVDVf8Ca9BEq+egyT+k364leLJNkT8oKda6df4=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO9VA-0000000035R-0pEx for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:04:24 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so32368175e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793693050; x=1794297850; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hMvYawKfxpUVaxgAJIzapE8qjzSEX0I0KSp6mXM3mC0=;
 b=AS4FuYDNREzVtjmJvT/wkb5UcFQPhM0t354ChMUH8HcPZfN/kpoCjjfMIDrLrUYpKG
 9N9C08XVKZ/UaTnPgiSNbkvtne1VcAw+cSz79q06Zg9DEsUaX9WFoMZ+XaQb59frRC90
 zbCwgWZPamHk1qTi9fQvCXw43DTzXNgam7r7eVUSzFlgJaHEWKvQn8hHxsFD/VMwBYrm
 A4ybvKYDVJkm5Gp9H/po12RSdo8nwE11Dy8tIxye6LIs5ZA6hQI6sC90xTE3MQWt3P9G
 +B4WroxQyEV+6Mcw0vkYEw7eK5O7ksbWUVGc6K3BvqN9Ry12VxmFvd62nTVKB35mfQLg
 igTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793693050; x=1794297850;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hMvYawKfxpUVaxgAJIzapE8qjzSEX0I0KSp6mXM3mC0=;
 b=Oe+FkLj7wPR5MkG9w1pOoDohr2QUToGruU3SxBcdxnuFkIhZVGX6K1XqBeU5SPzSh7
 AXpxszWN3tZBRpZ3L2A5qz+Xs8ph6JCKRomQA9hCx9KeyDxliVPLVXOkHY6Qo/fI7Lr5
 sI4fd5Fd0fVxD5TPa6NJ8MycPAVVIyiEsXkLAP4c63RVxEboOvTEojZNKKIH1moCSNSZ
 lWRlfQTOXk2HsKW5yA845jlZtbzxYlu2IN2rPi1db9HHWh7MG1PkU3v6PODRE9KYnKOq
 qE0ZB4/OCPesGn4fg6QVtBL8zeEsu9YX6nivDTfFTO8D0VWADnBbPN9VWED0mo3ZAOPr
 1aOQ==
X-Gm-Message-State: APuU4Z/2bKUDL0FcyTHTt1mdg/Bguw6VNF2knTIMM7PFjYmrS3VzZWlc
 EFsmKqRglmqDtsyZp1IZ1E4+FlQ6NXGgs3RhmiMBbRO57nhTpwlYSr2HUfTwj426Wkh0SzngmgC
 hLBl6jPk/zTTPJ2sdHZI27dkctxhiitx0zNE15bhGPgJjG3QQNgMqRAWYG6xdhzRssdZ0
X-Gm-Gg: AYBFou1fA3HemK4jEj0aRuzxT6bdp/2L+8IHnFWq4NLD81F7bAAQlqXGq64UPgPo43M
 rv5FabO1kwJo/8RHwkX7qlReiddtXa9x51tLKZCUDlq0fqkPUMyLTpo+pkx+fKZL65vJ7VBS6ld
 bpYbKmxLNACzfGLTtxeEVT4NysYdIuQO8j/uVIHxuSu3/PZBg96Ohg5p90be5gT8KGW5l13ZTPo
 SLGyodHqOyoSvJPUAuZSJePypxjz1ozUpwcbD1YKBdKg1kCIt+cdg67iveoEVcQmBcgxPNed8ME
 lC18FUdvBBk4eH7FpUJudLm/nhH5EivbmefbXMIrSLEgTOenx6yT3wnlqd6GI+S65akrQBQDzOL
 gQt1n+zBle1ys6iTYQXOUxhnG8EEx+XRzDcUa9naolia8JbRnpx76Ikw4FTtu6HkdJ1i0l2xia7
 wMoOMoqRHoMoJ3c2zPwJcuEUZ9HvOvXDXGIZ9XtYZjYbNkF0KtWX+FaSDnLBPlwSseU57fYp29n
 ZG4lOr+FdtMGx2x/IDqE+GFCtnffQiv3cAmgzghIQK3Jt1B53yUfrjVKQASelHHl3L3xVNMpwj6
 xd74fvEUh3qUO/G1HuNsXbvYew8s66jMZX0fRvPlmsAGqX10sdnLQ2VLa85k7Qw8kskCkPdUtOn
 2trtMX/g1Jyj4I8U5IvZgigVWxI0powCUXWau9j1IrY+G5Hpf+KwpBoeVFYBo24rBCXSBJXYRIz
 LbAcelsLHxSWGD0g==
X-Received: by 2002:a05:600c:a00a:b0:4a2:190f:cf6a with SMTP id
 5b1f17b1804b1-4ac19802310mr279820955e9.35.1793693049588; 
 Tue, 03 Nov 2026 00:04:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm56665035e9.13.2026.11.03.00.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:04:09 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:04:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
X-Gerrit-Change-Number: 2101
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2101?usp=email>
X-Gerrit-Commit: 6ff900bd4f226e6b1b1c992d531f3eb7d3111d23
References: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMDQ3MDAwLklkYjNjNTIxNzRlNTg4MDE2MjQwZTljOTE2MmExNjc2ZTE1MzFjNTUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b84de3991260969637ce5a7238f918c065ca28bc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO9VA-0000000035R-0pEx
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: check
 ovpn_dco_nlmsg_create() result in new/get peer
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
Content-Type: multipart/mixed; boundary="===============5111246906092344669=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5111246906092344669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pzs/EMcu9So="; charset=UTF-8

--pzs/EMcu9So=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2101?usp=3Demail

to review the following change=2E
=


Change subject: dco_linux: check ovpn_dco_nlmsg_create() result in new/ge=
t peer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_=
linux: check ovpn_dco_nlmsg_create() result in new/get peer

dco_new_peer()=
 and dco_get_peer() passed the result straight to
nla_nest_start() without =
checking for NULL=2E Return -ENOMEM like the
other callers=2E

dco_new_peer=
() unchecked since e34437c2 ("dco: introduce low-level code
for handling ov=
pn-dco in the Linux kernel"), dco_get_peer() since
5a8fb55a ("dco-linux: im=
plement dco_get_peer_stats{, multi} API")=2E

Change-Id: Idb3c52174e5880162=
40e9c9162a1676e1531c551
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
---
M src/openvpn/dco_linux=2Ec
1 file changed, 11 insertions(+), 0 del=
etions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/01/2101/1

diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_li=
nux=2Ec
index 4412ad0=2E=2E50d4c54 100644
--- a/src/openvpn/dco_linux=2Ec
+=
++ b/src/openvpn/dco_linux=2Ec
@@ -234,6 +234,12 @@
     msg(D_DCO_DEBUG, "=
%s: peer-id %u, fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
=
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_N=
EW);
+    if (!nl_msg)
+    {
+        gc_free(&gc);
+        return -ENOME=
M;
+    }
+
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER=
);
     int ret =3D -EMSGSIZE;
 
@@ -1229,6 +1235,11 @@
     msg(D_DCO_DEBU=
G | M_NOIPREFIX, "%s: peer-id %d", __func__, peer_id);
 
     struct nl_msg=
 *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);
+    if (!nl_ms=
g)
+    {
+        return -ENOMEM;
+    }
+
     struct nlattr *attr =3D nl=
a_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
 

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb3c52174e588016240e9c9162=
a1676e1531c551
Gerrit-Change-Number: 2101
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--pzs/EMcu9So=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">dco_linux: check ovpn_dco_nlmsg_create() result in new/=
get peer<br><br>dco_new_peer() and dco_get_peer() passed the result straigh=
t to<br>nla_nest_start() without checking for NULL=2E Return -ENOMEM like t=
he<br>other callers=2E<br><br>dco_new_peer() unchecked since e34437c2 (&quo=
t;dco: introduce low-level code<br>for handling ovpn-dco in the Linux kerne=
l&quot;), dco_get_peer() since<br>5a8fb55a (&quot;dco-linux: implement dco_=
get_peer_stats{, multi} API&quot;)=2E<br><br>Change-Id: Idb3c52174e58801624=
0e9c9162a1676e1531c551<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>---<br>M src/openvpn/dco_linux=2Ec<br>1 file changed, 11 ins=
ertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/2101/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index=
 4412ad0=2E=2E50d4c54 100644</span><br><span>--- a/src/openvpn/dco_linux=2E=
c</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -234,6=
 +234,12 @@</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd =
%d, remote addr: %s&quot;, __func__, peerid, sd, remotestr);</span><br><spa=
n> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dc=
o, OVPN_CMD_PEER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!nl_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return -ENOMEM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br>=
<span>     int ret =3D -EMSGSIZE;</span><br><span> </span><br><span>@@ -122=
9,6 +1235,11 @@</span><br><span>     msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%=
s: peer-id %d&quot;, __func__, peer_id);</span><br><span> </span><br><span>=
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     struct nlattr *attr =
=3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -=
EMSGSIZE;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2101?usp=3Demail">change 2101</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: Idb3c52174e588016240e9c9=
162a1676e1531c551 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 2101 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--pzs/EMcu9So=--


--===============5111246906092344669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5111246906092344669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5111246906092344669==--


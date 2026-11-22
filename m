Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74211606A32A
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c8/fh3y/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dc7fMTSc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ea0WffkO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Djq0Ap45
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=S5uVxLnyQCChtsKSEoOfI179qDLWWqkmt3M71Lankgs=; b=c8/fh3y/woOIlQP0PQEurtpaWi
	ng/Kmj0xVRIQ8HkOWItn8jPOYzif43vX3zq71f9PHy/C0nYjpGN+ZIB9rZQnwgBNDXe9+GEc5tkcb
	OfFNTIcKwyX0FsHY/PZgawcDiVKvpp1mHC9vzzRDHw3RbAp9unedrpKdsn3i3/olM15c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUwk6-000000000YW-42oT;
	Sun, 22 Nov 2026 01:51:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUwk6-000000000YQ-10UU
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 01:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2VkRlmhWMlsJJ13Jz18SODaIoz8Yp5amVy2sdHbH2t4=; b=dc7fMTScGTWDhbXXAgWMULBOms
 uLiuHbgsAqf5/5crwY6G0EJy4RCwCnp9UeUMmVfYmrdi4Fxu+3dvl7VQGLdw8oeaQWJVeyVz9DNaD
 jDDHDCHUoBlrZuW+t1E0PcKC41casG45nlpTZ51yN3znnZZ1i8XQqlBeLRaYGHK5xIsE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2VkRlmhWMlsJJ13Jz18SODaIoz8Yp5amVy2sdHbH2t4=; b=ea0WffkO9YSV7a0JW0QueTozmW
 4Ip0S3xr+CJj2GQ82EC9AkwPkq09H4wZykrtpVNiWEeQF2MQ7MwTGQdnimaSIjliwK/bow8L4gOjy
 6CObsTJO2Gr7hn8Y3k3g8Kle+zKf7BW4/KN7/A3/ZH9K0+yMcljW+QWsxCn8YDUKtpkM=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUwk4-000000002tI-3vbT for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 01:51:46 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so15761705e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 17:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795312298; x=1795917098; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2VkRlmhWMlsJJ13Jz18SODaIoz8Yp5amVy2sdHbH2t4=;
 b=Djq0Ap45M3becPwqN4GubaoGZ0xEOqYCu+jiBz3h7+VU3z71+IerwlZGPtrT1pCWow
 iWe9Le7e7Bkhhv5JcdiKfGn2wNfkxZ0jWA445u82ifmZGiguvJr6CUmI3rzZmwhDflWj
 lPQQW86EccAwdirZZ+wLpi0o6MIdPTuYodO5jGKXRU5YyW2gORF1th10X6VmzdN0uoLC
 vidDbZcBm/NS5A6gRDIymZ8bXw27xhbd5IRPB8pkXoJW/KiOsl0b/KgSpkqrFg5kolbI
 xeSl4lcoXXM+dLk1SCrpKvoBqXjtcecgphFyg/2f+RgWKrE05aW8zxzxUccLzNQuyiYP
 uqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795312298; x=1795917098;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2VkRlmhWMlsJJ13Jz18SODaIoz8Yp5amVy2sdHbH2t4=;
 b=GnVJ8Ua8rNyzOofjz455sz1ozZaKJKq0LIoZvWpEpk1EzgTdBBdStWOOYRJog1iBq/
 mKy8rTHDOaCUTYaymW/StKXT5qMASpuaQWvl1fwrMlsIB68tY5zYoxOCNb90gevbK822
 Zr8YCqWNxyEXf5Jw86BSQW8Z+C4IU/GirE9wls0Y6Ia3FRSIoxIQ3otS8BDP65NoHZjw
 zTleColJ/DXHjwsPV5Im56qpBinCeuwbWBO6eXiymhcOwwaPdl1Dwf58FYCUKc7B5LOs
 QUa4FAj/z6/rSmaxapKnWzpzX1WFam4Us0yKh054LVxZH+DhahMgOR2wa3e1ZqIwaf0u
 zcXw==
X-Gm-Message-State: APuU4Z/7qH3W5HTosScXk4bJMz1umSW0jSBlFuUXZ6LT+BNUP9ANa+6Y
 jkGy0Qda//447YQlYK27Ga1C9GXt3tyLAdAyiBOtoag2hEUv4mvBIC43fcGxQ+YP0G5jgbxs46h
 pIFBSobbMd/X1hgeq8Ha2eaGqVwzDOWdRLBj9mkB/0GvzBq33PcI+v58Tt+32MtShDUUo
X-Gm-Gg: AZFdTZeO4oG05HBFYrfUYhph7I/OoBkGqdKKv7qWhjR4genMHjo9dTfwRSLVJBj6P3n
 NatMOx7kFOggRzqI9POQjZPv65xwV/d0NaMUIlmj70hLkTiQ0iMFxQ/q273X0hv+X7FDDmnHvEw
 RGQGk5dcs74OStj7fWLm2evW6z8sLJx8sF9BL+xt2U0k67DEF/jokyGmTVs5gOb4DtSZ2aUuPtn
 iiCSuMKbSzGauXXgrJeGLxsixGp9esWBTsLolazZE3CsOU7GYbb2NuLwAYAs/XwTCy0NcXCwQRw
 SN5SVvZLTVBMsD6ynUq7rvahyDXjHI2+bsZDiB2ZkwFU0fi+yIZ52wT4nZpiWGu035kZwKwTHAP
 CflqYGzUakiAsh8EqK8Klq8XhCYJeFfRds6zpZOzljVWq2gmvKC0XDN65AAkMPn3OhDzlqBsTl7
 gxzaac179VaKwNxm65rHhX5H86BRIo7pZvRx0VsRCjz/JktI0E3eL2kULsKtm9x2l67dyjlYtB6
 Z7lFvkJGh0UaI6s4vjpLTfkqMHZ0FTklsN0DugUTcSVjP8i8zZ9yLK5YueLhciS5RdAw5uoDgvM
 Dwswt1swpHX/2PlCx1h/TWyacWtAAvKp1Ox33DtRwFDVkApLV0UciVR2w1rDyEUDezUdrMcqVvu
 5FQG6BLM1eXqgHLtEhmTNl+0lNocwF1yzPVVdqZy+9/NL/LbYQJsdq9K6RpSqFfoy704BFqOYGP
 sfO5ArsjgxasF15nc=
X-Received: by 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4bb8880ef6amr172439495e9.14.1795312298232; 
 Sat, 21 Nov 2026 17:51:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067846esm93182485e9.4.2026.11.21.17.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 17:51:37 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 01:51:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
X-Gerrit-Change-Number: 2234
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2234?usp=email>
X-Gerrit-Commit: a95dff7ba064193f081a2b93028421a3f890a3e0
In-Reply-To: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
References: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLkkxZDM2OTk2MjE4YzNjNjFmMWYxNmUyYzk3ZjkyMmFmYTY2ZGY2YjY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <219a90c028b97a94dd843ce6cc5bc287be39846d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUwk4-000000002tI-3vbT
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: check
 room for the DHCPv6 name server separator
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9208552837698880756=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9208552837698880756==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wq+ckAGlnYc="; charset=UTF-8

--Wq+ckAGlnYc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan=
 Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to r=
eexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2234?usp=3Demail

to look at the new patch set (#2)=2E

The followin=
g approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Coj=
ocaru


Change subject: openvpnserv: check room for the DHCPv6 name server =
separator
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: check room for the DHCPv6 name server separator

GetItfDnsServe=
rsV6() added a separator between addresses even if only
the terminating zer=
o still fit into the buffer, overwriting it, and
relied on inet_ntop() fail=
ing with a zero size buffer afterwards=2E

Return ERROR_MORE_DATA before ad=
ding the separator instead=2E

Change-Id: I1d36996218c3c61f1f16e2c97f922afa=
66df6b66
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src=
/openvpnserv/interactive=2Ec
1 file changed, 6 insertions(+), 1 deletion(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/22=
34/2

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/intera=
ctive=2Ec
index 24705a9=2E=2E32b1688 100644
--- a/src/openvpnserv/interacti=
ve=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2256,7 +2256,12 @@
       =
  {
             if (i !=3D 0)
             {
-                /* Add separ=
ator */
+                /* Add separator, if there is room for more than t=
he terminator */
+                if (s < 2)
+                {
+          =
          *size =3D 0;
+                    return ERROR_MORE_DATA;
+      =
          }
                 *pos++ =3D ',';
                 s--;
        =
     }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d36996=
218c3c61f1f16e2c97f922afa66df6b66
Gerrit-Change-Number: 2234
Gerrit-PatchSe=
t: 2
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlic=
h=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Wq+ckAGlnYc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan Cojocaru=2E </p=
>
<p>Heiko Hund <strong>uploaded patch set #2</strong> to this change=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">openvpnserv: chec=
k room for the DHCPv6 name server separator<br><br>GetItfDnsServersV6() add=
ed a separator between addresses even if only<br>the terminating zero still=
 fit into the buffer, overwriting it, and<br>relied on inet_ntop() failing =
with a zero size buffer afterwards=2E<br><br>Return ERROR_MORE_DATA before =
adding the separator instead=2E<br><br>Change-Id: I1d36996218c3c61f1f16e2c9=
7f922afa66df6b66<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2E=
net&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 6 in=
sertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/2234/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br=
><span>index 24705a9=2E=2E32b1688 100644</span><br><span>--- a/src/openvpns=
erv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</=
span><br><span>@@ -2256,7 +2256,12 @@</span><br><span>         {</span><br>=
<span>             if (i !=3D 0)</span><br><span>             {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                /* Add separator =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /=
* Add separator, if there is room for more than the terminator */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                if (s &lt; 2)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    *=
size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            return ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                }</span><br><span>                 *pos++ =
=3D &#39;,&#39;;</span><br><span>                 s--;</span><br><span>    =
         }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2234?usp=3Demail">change 2234</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d36996218c3c61f1=
f16e2c97f922afa66df6b66 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2234 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigent=
lich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Wq+ckAGlnYc=--


--===============9208552837698880756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9208552837698880756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9208552837698880756==--


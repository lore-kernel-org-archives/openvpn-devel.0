Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403A606A32E
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PVSxhDIL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jOAaoJ1t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bd3l1YXz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bQpl0cPu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=s5QSU/tObslLD2Qy8/kmdz4jKgdMo3Xe0JJW7E8y16M=; b=PVSxhDILgbyn2fCVdhkO+9l7s5
	5Gt3WvVn0IgM5uoPL5GjPAdj2igaqVX8Hmbu1FgIkG0kTGxf9SFkHvpkzpXwuayrcLtmaqI2D1K9C
	cPDw++yor+9Mor+QLShpKP9QFz7HpE3tc0il1EQFeqnP3c2gCryq8RtqVnnK5evV+fQc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOWf3-000000002sv-0N1x;
	Wed, 04 Nov 2026 08:48:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOWf1-000000002sn-1duf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:47:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qURPKPvZCMTI1fy8kLWKDzR7vqrXywIiK8tJ+5cQN/c=; b=jOAaoJ1t+dh5YQPMzpornwlVbG
 k658x16If29HEjzrfP3GBLk2xr0+f5PY9ye2m8CmJ6EkrahF/b4eLOOHG62ap2IzONLK8KzRdfthq
 bFMR58y0+Ax0n4eS/gNMKSmeLkXjV55xT2Jk9b2NxuZYm+1bRgBBSxvNeCutH7qzStQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qURPKPvZCMTI1fy8kLWKDzR7vqrXywIiK8tJ+5cQN/c=; b=bd3l1YXzZedk8LSNpXmxBHJMKd
 kQ6YlRUNEAJgUDtRlKz+9PJ1cuPEbtpLE+CwshK5VfBL7sDlpKJXlDBk2GAsj3+gcGJQPsp7EDmAz
 b+rk8BqCCKVxkC6rZQcclP/c54Y9EXC1XRY80B+am6O/EFkYyvv0ORp7LlOCKCACOjB8=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOWf0-000000003L1-31mU for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:47:59 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so3548385e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793782072; x=1794386872; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qURPKPvZCMTI1fy8kLWKDzR7vqrXywIiK8tJ+5cQN/c=;
 b=bQpl0cPuOFW0aUzZGoy3LDTSjMzBRF4FtU86CGZrEwDAQ0oN5j7jgciYv9tYrNccTl
 aykh79lvXsacKNkhnf9+BVwUax0oIELVNxVBbnj8inb1EozQtqKUDxbz/L+qDXMFJEzB
 uWlnfA1AQ54p40gEUFnP8aeaDTYWrA0qK5t78N5l3RWJ9+bJ+wv7zcZAdM1MqwnyK8iz
 zN1M9Nn7HTVdIv71JkrQIQ6Vo4gbpIRRJ1PiRYBVAAYPGn0p942k8o3gQuI0evhS1KMp
 JuU+ObLk3nLdyykTGqR+VX8QQXdxf04gL0UKDFIFO5lA6+LEE1qaD7hX9CtWRxky489X
 kx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782072; x=1794386872;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qURPKPvZCMTI1fy8kLWKDzR7vqrXywIiK8tJ+5cQN/c=;
 b=XQiRA5egc5/xNAGZucl8lH98yVcLK/XgmZ+ln/lCdacqCJaj5GSzU/KJUQ1AZdcpLK
 BDY7LCG7nHYBOHGU3eefJ2MKtzNJPws1Du6CEvf6Z7nfX9UCoVPztpf3V58iWJH6KQ/k
 UPhlI1SAqUMPZqGdGvQ5PVyd08b3h5jFzAAjcIW1iYEwnqGrUN8LMe2hnFZpiMT3cDaT
 FDzGoO0cDnvRYqgcRFIDPbEyDoo1jdy88rJDrQG/fWp8gBmwN0z0dPO/+nQYne+8ewic
 /rSIy3cg9vIRa09joZcM5640rcEOdNeSfEm54BBRLfRjlK4PgB3fvlHKMH8/TBNCmEoA
 xtxQ==
X-Gm-Message-State: APuU4Z8F1lO+iql7/AVxv/PEGNUCcUGxodXCnbgfgNyA38kPNntPxTX/
 0Y0Hzw+dn0ppPkJlUO5P5ULwSSKDMJraxXEHwtD47aFmGKZaEdcJWxPpXd4VjIJdH8Pv3ema6z1
 hkni8qAWFD8+LIptlxRPAZI9UCKNsujjiBEkt83XwI5LDB2RYv2GGSqIVemW4KYD4JrRvbKamQ+
 4bzGTVYw==
X-Gm-Gg: AYBFou2RUUZzwiGgnhCQEx8XS/2yTAs8b9hBCDAvJS/WMUi2B/2gwHHtV68YZvQ0BYw
 aXXrIfCJUNqInsu8jPwO1/rTsEwT7IUpZr8IVZ+HFwuei7dCj6tzE6RhV349WcaJly8jv0GpOeb
 pDYkFKk5J7LWl+8slWy0kbFYjQQVb0ZDcW9AkUrxGLfmyzOug91Br/gs6cwQCX3Hr7jGCKMVP1b
 rdGWHLhYCzgJDWsiwO/mxsFQcsJymzx4Mj1rGNGU3QUoaHijYAkMi8Enh96g2jzMzesajnfdkli
 1aFWpbNC32LFMsyIG89MOgpS5+B1M6S8SS6RJ86NynkiK8cNU0G260YvA0FCOXYZqDrMRIrNRQl
 p0VPAOgOy8vFfRSzNyL/hsUi1ynB7MM9QLksRmuHePPkw0nFEEfAa3fR76w/8p02dbli9dC0HVg
 FtZAA/2QD+j1uNPNsusTXzFFEybUlBqG57tX3pfDK99jminY06srkq2CmFzMsy9JNcC6d3vMRSn
 zfNIqOhDYBkvn5SAj5ABOWbfr5YG83nMJnTbvxxuD9ejbnacklCGegj3wKuPJ6A87UJTR2ZZt2Y
 JSGpBEjKeUj+WtDv3dYH0sC70Wev9JjP758dLNmU7XIPdCf7JwfUAWcmfiDYfR1lqrpJtfyIi2k
 yrJNLTUa9LhbFhe33yakphkcemGMJNAc4ubkfTdjhthLddzVUL2a0SNNxF2kB6ackdgAcdU7Q1M
 XmMO3tojmk+eOysA==
X-Received: by 2002:a05:600c:a45:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4ac1932b43amr365069395e9.31.1793782071911; 
 Wed, 04 Nov 2026 00:47:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9fafe08sm199851655e9.3.2026.11.04.00.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:47:51 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 08:47:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0
X-Gerrit-Change-Number: 2128
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2128?usp=email>
X-Gerrit-Commit: ea64f4bcf2968e0d4a935fd6882326bacf599193
References: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgyMDY1MDAwLkk1NTQyNTIwODI1MTEyZGZkNjRhYWIzMzJiZDc2MzMzYjc0ZDdmZWMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4d29ad43250aba21756a8abe08a06f9468e094a7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOWf0-000000003L1-31mU
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 return freed token groups from GetTokenGroups()
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
Content-Type: multipart/mixed; boundary="===============3354033004721535900=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3354033004721535900==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0W2YMJH0NAU="; charset=UTF-8

--0W2YMJH0NAU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2128?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: don't return freed token groups from GetToke=
nGroups()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: don't return freed token groups from GetTokenGroups()

When the=
 second GetTokenInformation() call failed, the freed buffer was
returned=2E=
 IsUserInGroup() then read it and IsAuthorizedUser() freed it
again=2E Retu=
rn NULL, which IsUserInGroup() already handles by skipping
the token group =
check=2E

Broken since e82733a1 ("Fix user's group membership check in
inte=
ractive service to work with domains")=2E

Change-Id: I5542520825112dfd64aa=
b332bd76333b74d7fec0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>=

---
M src/openvpnserv/validate=2Ec
1 file changed, 1 insertion(+), 0 delet=
ions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/28/2128/1

diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/v=
alidate=2Ec
index 6a13a06=2E=2E2858f62 100644
--- a/src/openvpnserv/validat=
e=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -227,6 +227,7 @@
     {
       =
  MsgToEventLog(M_SYSERR, L"GetTokenInformation");
         free(groups);
+=
        groups =3D NULL;
     }
     return groups;
 }

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7=
fec0
Gerrit-Change-Number: 2128
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--0W2YMJH0NAU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: don&#39;t return freed token groups from G=
etTokenGroups()<br><br>When the second GetTokenInformation() call failed, t=
he freed buffer was<br>returned=2E IsUserInGroup() then read it and IsAutho=
rizedUser() freed it<br>again=2E Return NULL, which IsUserInGroup() already=
 handles by skipping<br>the token group check=2E<br><br>Broken since e82733=
a1 (&quot;Fix user&#39;s group membership check in<br>interactive service t=
o work with domains&quot;)=2E<br><br>Change-Id: I5542520825112dfd64aab332bd=
76333b74d7fec0<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>---<br>M src/openvpnserv/validate=2Ec<br>1 file changed, 1 insertion=
(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/28/2128/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index =
6a13a06=2E=2E2858f62 100644</span><br><span>--- a/src/openvpnserv/validate=
=2Ec</span><br><span>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ =
-227,6 +227,7 @@</span><br><span>     {</span><br><span>         MsgToEvent=
Log(M_SYSERR, L&quot;GetTokenInformation&quot;);</span><br><span>         f=
ree(groups);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 groups =3D NULL;</span><br><span>     }</span><br><span>     return groups=
;</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=3Demail">change 2128</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I554252082511=
2dfd64aab332bd76333b74d7fec0 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2128 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--0W2YMJH0NAU=--


--===============3354033004721535900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3354033004721535900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3354033004721535900==--


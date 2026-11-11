Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB52606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LMHCMhVZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lUnESUWS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U8sAOx4r;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H7e3w2+Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8lWg9SIKKXjK2Xsl4+QUYnyFBmg7y5/dtSDhaX7fDKg=; b=LMHCMhVZNOTnruZTMvmw+abycd
	pyM0X/XMoi4X086hjpvbySct7mpq4sj0iGglN4qCdB4cLQorVP6+gMfM7TtqqshYNZ1HYcR+QoO6p
	9JVqSlFXgDu3qhxn/nygGKWC/9xCg+Nt1bigdB9gL49Do4s2Ff8yzEhzrAzTe/KrjhcU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR8c5-00000000171-2v9X;
	Wed, 11 Nov 2026 13:43:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR8c1-0000000016X-17KD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:43:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4LxArQINA/QoV+Cb622Ea+d2/Y/MVA2ITPb0vDr0pE=; b=lUnESUWSjMz1uBI0/UknMZDzdO
 Yya9DhowdN3hZIUfR7UtEFbQq4zHFao1wXmnnykiizbHTQOgMLsi8t2jSEMHddfhjsxPzXWuyz7iH
 +p5Pn5ZSuHth51n+HGrX5h112Edfp280PDHcwJTEJAy8s88zucdwrnmOKarP495hZEY4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4LxArQINA/QoV+Cb622Ea+d2/Y/MVA2ITPb0vDr0pE=; b=U8sAOx4rxzxeRwS/w8otUZCWo2
 hSvJmHOWLotdWuxk+bWkiYXu87plJv5k8DVrPZlLbUPHp8zfZW2QlMMrxCuQbnKQRirhyZKopgW0q
 bDAyE1C9RiffQGhJH8R1yxvyUIzQaA73dLHq3Cloa8v9uQbRth0Ym8WF3YDUwW1UewPk=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR8bx-000000006qX-1K5k for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:43:41 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so24818305e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 05:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794404611; x=1795009411; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q4LxArQINA/QoV+Cb622Ea+d2/Y/MVA2ITPb0vDr0pE=;
 b=H7e3w2+ZL+5TH13GA1wuk+3zt8uQrVd7nadiAV1p3MaN7DhthsWQIDE+108iInBg2K
 1SE/SEQKiSKUwRrWudWNZRWzwsZVS7k913MfXdfMowEOSxvs3rXT4tK0e7pS5FnnYJQi
 8pTk4wG9EH1DbmgThg/i0ngjG4Jvr/ut2pXgsDfD8HFl//o9nB6Z4jw7/YlhrRIdwXd+
 eXXsOVA6GhLXH0Fy5E1M0KX1DqKSi0OE3rQP0Ug/o8T16NqJIQG8Xvfv9L6Mn/A8vNkS
 TsE5LZ9sdkVoh0k0kQIKLX3l2OJgAY2BUNNQgXCJI4IOc7wV2Futuil2Sh7TyfqnW4y9
 LDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404611; x=1795009411;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q4LxArQINA/QoV+Cb622Ea+d2/Y/MVA2ITPb0vDr0pE=;
 b=XenBhpmwVd7OgKJBF/H4n0Ak2nzptonyDXb24xXHDftfZEArVLLGp2HGRdjTlizzbH
 9p8ZEi2UNxaGRlUZ3d34NIGgo5IH5DU+ANyGWp/rOWAZClrwsk3TRpI8w1CxFbZxMxaG
 Vixxk91k53mvw+VrC/t0TReQQvU5P8MnE+G+EWwZfcF+x/rGWPhJBNf7/BEwDkVNrtae
 bcdz6lH+XnPdZxnlX12RqwnfPD97bImrPkE5APSXbwnWwY25WXLLiYkSvLdcjyeHt+nJ
 YPJWZsMUSLWG65DzrfGcLRTZ1xxPuoOl8kIOdVAakGOm7sB+tdWrgqMrkWiapZFMcp7A
 1Fdg==
X-Gm-Message-State: APuU4Z+v92LMqW+pmkrn/0H+Lrecla3NO6eTF1D+tgeYhNcuPzIdZKJd
 PCxsLC9f1Gamy9hW+RwSgea4cixAGvH/Tl1Crnpg8wKcphiFIpEpNLPuLuem0dS11I2dAJfedCi
 OrcdFn9XhSq59ySjXLqnTBtjiOfWbI1hKTZsufx5aY2YhdA6Xm6P31wJNfvEPMQ6jKcfHiz1N5Y
 4/O+3J9w==
X-Gm-Gg: AYBFou323BsTsIF9r8jpa19E0+Bg5Mqo3lfIJEtH9TCYr7ebTwAFmW4S8ePEe91kxEj
 vxFUfSTERvU4/H/p/J1pFtUTyLGz2j93al6tt01gjYGtozPjy5/+eWd32JYFp/Mnn47o6dq9PMv
 1Cb9QLQaPiedR2ZH91W0+qVbjr7wBAbKss7ixnN3fmeeooeKqxI8SH6BYrSNSc577kxYUlq2yfw
 eS5DLtr4i3Nki8zaOgsKTYtaTftAza2eOk2bRpW4yOGEsXH8aqeczpkueOVH88256B2XiMap1ZO
 BGNfMKacR8PQN8r0PMV1sBvjR+s1L6IAUGFPC2pvkZGsjw+K/Owa7sgpH0AlxxBoD1clrxQ9PWH
 6TF9WkF7blpFxLCOnwa9k5Fsiwjux47M1G3sC81bMiBbbCxrpJGjnrziZj/NC4BmG7p4QeTKrEW
 WK7NGxz9Uz4HoxFOTEL+6vNU3JBYE2pXggWTUvaqawOHfbSPkU3+48NxQKx6YkChVI8nPb7+FoZ
 Oh6oo4ld1DT+WBnNMQgyVDnr2GRVKCPT0MZbjLPdsK5zMaH40zVIl3jbHjeYwghwKavFcPEk1lo
 zOjXaVWIRf7QgO45g3xokvx0hFAPL1TU/aP/V3kBW/S7MIjPiyqs+2Frqs0tww+LR5eL4qLsAmc
 JJ2Ei/K3Vw8dtpnpjIWP9ab6PWGxnsskHRVO5nWa/BjmboodIjPhBM5It1EQr2oYsxkn5t6OiOr
 1OJzYutaiL/2v8a8g=
X-Received: by 2002:a05:600c:4f09:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4ba09383b92mr46449955e9.23.1794404610420; 
 Wed, 11 Nov 2026 05:43:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba020485bcsm133356905e9.11.2026.11.11.05.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:43:30 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 13:43:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 7c26995119d4b1dbaf696843e8017ef7fa1cea33
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 13:43:29 +0000
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2740d355ee721e734f5a92aae4e460a4190846c7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR8bx-000000006qX-1K5k
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
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
Content-Type: multipart/mixed; boundary="===============4849237928480964286=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4849237928480964286==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wZeOWLx5w6A="; charset=UTF-8

--wZeOWLx5w6A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2175?usp=3Demail )

Change subject: Extract tls_pr=
e_decrypt_extract_session_id and pre_decrypt_find_session
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2
=

(2 comments)

File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2175/comment/d00ea4e1_f6613a14?usp=3Demail :
PS3, Line 3769: tls_=
pre_decrypt_extract_session_id(const struct link_socket_actual *from,
Shoul=
d this function also have a Doxygen block?


https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2175/comment/9a6c6ddd_3683b8e8?usp=3Demail :
PS3, Line 3792: p=
re_decrypt_find_session(struct tls_multi *multi, const struct link_socket_a=
ctual *from,
Should this function also have a `tls_` prefix (like the one a=
bove)?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/217=
5?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I230b3b248=
3e15477b179b277dc8f7c91c53fa0c0
Gerrit-Change-Number: 2175
Gerrit-PatchSet:=
 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 13:43:29 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--wZeOWLx5w6A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2175/comment/d00ea4e1_f6613a14?usp=3Demail">Patch Set #3, Line 3769:</=
a> <code style=3D"font-family:monospace,monospace">tls_pre_decrypt_extract_=
session_id(const struct link_socket_actual *from,</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should this fu=
nction also have a Doxygen block?</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2175/comment/9a6c6ddd_3683b8e8?usp=3Demail">Patch =
Set #3, Line 3792:</a> <code style=3D"font-family:monospace,monospace">pre_=
decrypt_find_session(struct tls_multi *multi, const struct link_socket_actu=
al *from,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Should this function also have a `tls_` prefix (like t=
he one above)?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">change 2175</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I230b3b2483e15=
477b179b277dc8f7c91c53fa0c0 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2175 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Wed, 11 Nov 2026 13:43:29 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: Yes </div>

</body></html>
--wZeOWLx5w6A=--


--===============4849237928480964286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4849237928480964286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4849237928480964286==--


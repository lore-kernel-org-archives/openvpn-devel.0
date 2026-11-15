Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A0606A31F
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tp9b7Clp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cluf7y9m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ca6uzkh+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TkKri8fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a2izqcEqrzAon94GB+JyHSdj5Gpf9qCoUvJ0nYuVwiU=; b=Tp9b7Clp8811fwP5vHuo5O2CzL
	atSaVxrfvpgCQslhi+NZf1sFQW87BPy6HMYUMJCaGznjdd/Mjmkz27NfTIr8WAzx83qJNKhSezkJy
	6yn1KdDe3OBDKJ7zA/W9XvnO0uGZriavcEFiSKBxoEAymOnS7gus6ko4ezdUoXFhvgFw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSi8x-000000003Pi-08IY;
	Sun, 15 Nov 2026 21:52:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSi8v-000000003Pc-3QUD
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P2o1R/mbLuQkxABQMvGgXuqFF2UTgz4fjU1L5EDp548=; b=cluf7y9mAny1stctwG3inBa+OF
 WaOCbnaGIDLLv222VrkRB7A1CVhpYWnHsLMuhWnPpJlTvQyIs6un8xmxaPGzEC2/us8TJFZzGlgvp
 N6f4cX7DrBwV93bTicmPYHsvK4W0qhEijrnSfKbrs+5SJOVeyQsLgW2IrgDiKQHlQNPU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P2o1R/mbLuQkxABQMvGgXuqFF2UTgz4fjU1L5EDp548=; b=Ca6uzkh+vyTGGn5QpEx9WHXfIr
 AusuQ5HEMCyWtNueYiX1HhZ/GyvUb+lbRmS0WlibFCxDrJ3zTUk+B6K+jzHHDTfKz3tk4CvXUFu14
 NtlSYD2mnJELAc4DlpYW4wts6jVi40SaTJEM7Xx/cEHXAMoUfJM9zfshkI9iRCs7b5UA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSi8u-000000000Zn-3qBW for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:52:09 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so3302125e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 13:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794779522; x=1795384322; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P2o1R/mbLuQkxABQMvGgXuqFF2UTgz4fjU1L5EDp548=;
 b=TkKri8fr2L2szkJGN/UzTfyzs187OJp+rL+w2fU3y1njhsZSFCgSkgjHsRTZjG1RaV
 g7i6oF8ChX5+OAqfldwDSgFD29P53X81uuawLRrnTCDG/PwlHsxzW+7szBpqF5I1QmwD
 Kbzai7dNuyhKZp7n3/iX0fr5jmbklCNMykxy4NIMgmgms9YUF00HVYUXqQTtUbIawaPO
 j1g5cXTvJFScvpup441OYX3KGirc7DRhqoF7GOPoEGjtcqNpvsLuozoZ+yamzzM+OVJ+
 wcIlYCX3j8sY7dAPmipXk5FZhfwAAMmJLWaZG5Z2digL+6V2CO6bC1Z/QsIx6FD1CfaN
 6pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794779522; x=1795384322;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P2o1R/mbLuQkxABQMvGgXuqFF2UTgz4fjU1L5EDp548=;
 b=K3mFjFWit1XFMLLt1k3AiYIkDuQuq/yuLL16vRxlLkSCf6uUSWEafnOH8xrIbKyeD7
 ST9Dj9TS//FbrRKqvzSaX/HMgRPWiMwo8SDOcDZiYgQH+GYSSFDxEoEJUpxNEixeHNvB
 wBHQPLVurlcukecMYE/3Bfc0lTPAUyP1yebQnajmr3rR4RDfQpqKnrTvsVuIs8l3LpZr
 BRS34fPn3Qdr/1hA8T91PeE939zSm/flVCZF2bBUZcOlfptNNG8QQKjNgfhLaxI/Qq3w
 s8d1I9jEn3MH6pjoWxOXSCHdidZvClbVnN0vIokYt3sAceo8B8UxzYwezu7/00btQAQi
 PRyA==
X-Gm-Message-State: APuU4Z9ckyj8PZWJnkk1kSQnU3lpFFqLZycCxqzvHiXlw5ujvqy0P93V
 eL//FJ+EkEG3wbN06eAVyXBi41kqRjJJ9QmsujGIA42WPtetdfGf2eriN7y1ZaI5DAaW0emLQ44
 BBmiCKL1j4JBg2JoC2hejexWKF63J6DsTm72M6qVEEBiKmx/QYQsmi7rlmHjbxQxDbYv5
X-Gm-Gg: AYBFou1YogKUKl6BSJp1ldEsoq7ueVjOd4uwRB6cDGNAQBpBHAt5eGuWPh5q3cVwJQa
 MfJIF+wJxHWD+50vU7UWM/w2zmR7MYtb6GU9yu7sykpEU/HA8XU25llddH9IR0ISXliXtqbi9i4
 dYT+9N5AkXFbSgyYHnnveSbqac3dLAmWwY9pjWD7aH63LlUCxeXukHTBArG4TbQoutnhHMMpGyU
 Q0fsJrvIpZCKstfdbFbQn9v4Ag3/NFlh5jEe1uC/JdmfIyLihgq63U+qimq1PxhvXWYvLiWvVpC
 W7HUzyuwqDKjqTRIoLG9pbM+EGSPk15oJ03DYb95eRZ1RPcI1Ja7PzuB3DRCmWfriOzbe/+FN6v
 588DfZ+3d0WT12MUTdljhF7zZH0mI1HTC7aH4B9Z84vHg00u51y65EaWaPMZv2UobMs+6fvb7dp
 4EY/nl6/hyDakYuqSk126ixgEI2OthLY90hpFFqGsXz0pNbeeV4m8s4HgMClDkBEP3pktzcnByb
 Rni0/iHtS2XIErKHSzfiESYQwKR0eQtxbbHYSZZXnIsYId64XMV+iZeC4zLqdHNpMYGpGN+OImt
 YhcmWH6bQnWFG8i63vMgBW0GOvKYQv2gzshkh72UfnqhqO4uFi8HB440usmHrGSo799jJ+BXY6F
 A4payNPCiRekfeB3tJXxB3kbAQuOjI849iGMDSLOz6PTKh1saMyy1bvTNdIrSREhqpKKsaN1oL8
 m7N7hd455z8MDdZYE=
X-Received: by 2002:a05:600c:6212:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4bb5e65fc18mr156634395e9.0.1794779522193; 
 Sun, 15 Nov 2026 13:52:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb52bab8bbsm248764555e9.13.2026.11.15.13.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:52:01 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 21:51:59 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
X-Gerrit-Change-Number: 2184
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2184?usp=email>
X-Gerrit-Commit: 59e30622405b59197d32d839cf5185521a0b1088
In-Reply-To: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
References: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NjUzNzA3MDAwLkliOGE0Nzc1MWJiMGQ1NTkwODNkMWE1MGFhYjgyYzA2ZmIwZGFkMTEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <28d0168ddb26069b8c5222e0b15f3ec3c3b7e310-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSi8u-000000000Zn-3qBW
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: Include
 dlfcn.h for dlerror()
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4878350182660012535=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4878350182660012535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NRj2eQBeERs="; charset=UTF-8

--NRj2eQBeERs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2184?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: auth-pam: Include dlfcn=
=2Eh for dlerror()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

auth-pam: Include dlfcn=2Eh for dlerror()

With --enable-pam-dlopen=
, auth-pam=2Ec calls dlerror() without a
declaration=2E Broken since ce8271=
f5=2E

Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
Signed-off-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184
M=
essage-Id: <20261115170015=2E10294-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41375=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/plu=
gins/auth-pam/auth-pam=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/2184=
/2

diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/a=
uth-pam=2Ec
index 0cd201d=2E=2E72c047d 100644
--- a/src/plugins/auth-pam/au=
th-pam=2Ec
+++ b/src/plugins/auth-pam/auth-pam=2Ec
@@ -32,6 +32,7 @@
 #incl=
ude <security/pam_appl=2Eh>
 
 #ifdef USE_PAM_DLOPEN
+#include <dlfcn=2Eh>
=
 #include "pamdl=2Eh"
 #endif
 

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2184?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
Gerrit-Change-Nu=
mber: 2184
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--NRj2eQBeERs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2184?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">aut=
h-pam: Include dlfcn=2Eh for dlerror()<br><br>With --enable-pam-dlopen, aut=
h-pam=2Ec calls dlerror() without a<br>declaration=2E Broken since ce8271f5=
=2E<br><br>Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2184<br>Message-Id: &lt;20261115170015=2E10294-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41375=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/plugins/auth-pam/auth-pam=2E=
c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/218=
4/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/au=
th-pam/auth-pam=2Ec</span><br><span>index 0cd201d=2E=2E72c047d 100644</span=
><br><span>--- a/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/sr=
c/plugins/auth-pam/auth-pam=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br=
><span> #include &lt;security/pam_appl=2Eh&gt;</span><br><span> </span><br>=
<span> #ifdef USE_PAM_DLOPEN</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;dlfcn=2Eh&gt;</span><br><span> #include &quot;pamdl=
=2Eh&quot;</span><br><span> #endif</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail">change 21=
84</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2184 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--NRj2eQBeERs=--


--===============4878350182660012535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4878350182660012535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4878350182660012535==--


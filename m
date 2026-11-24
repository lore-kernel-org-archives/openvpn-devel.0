Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A69606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WbLnj4V5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hbdLxmol;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NgjnHaD2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eYq+IdQ8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=63OL6W44D5nlWOK8hdGAArSUGflbsZ1IBLi74gIxbtk=; b=WbLnj4V5iuOjKWBPOEciRTAT1q
	J5iISpQF3wgFQ3FNqOZwiD2HSKgOW2YrdSryTOuqL0szaon5xLTQW9Xkf8Byh/tEoIfF190Zs4Bxt
	MMIGkimOkB39N91bgQy4s/rEHykWWiIv8dDqSyg9T09O8SetY6ndxusKYP6SGi8YIasc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVreS-0000000018n-43JH;
	Tue, 24 Nov 2026 14:37:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVreR-0000000018f-2OOH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UEX4o8k+Gww6m4ANwU1ZxzsmQOir3DC/2QPeI+E/xCI=; b=hbdLxmol/jVi9V9mvtkH0BtqDM
 d1SH01yUejAPgPU24/NCowpBthmDtQ7oeabkgrfwyJx4HK5ZlhXyC3y683uA7mbwmEbShbNYZG2bB
 /B4MsQlari+6xcpja6A4vOQ0TvEF43sJtUkdebhFFGD6l++2k0LX/a1n62ULjAlSmPfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UEX4o8k+Gww6m4ANwU1ZxzsmQOir3DC/2QPeI+E/xCI=; b=NgjnHaD24HlFyc41mIWupqDP2v
 cIBpMILSARp6vUcN3+UGt5OMkTl61ZUgjxLVVdSI+fPEJ9Hu+vP3V5qCV+DE8P8MuC/jevOCzqpau
 aRWx6uQNcaM1CSMLYFrKK9WYGZpfoM9KknQgUCM96Z573PmRMFIfGwmfHPcj8gUwdO54=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVreQ-000000003vB-0rPF for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:37:43 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so2643337f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795531055; x=1796135855; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UEX4o8k+Gww6m4ANwU1ZxzsmQOir3DC/2QPeI+E/xCI=;
 b=eYq+IdQ8lz3Gy2y1kOO0cT1BriRT1XU0ZqruFlhzx83JPzqHHOwHTkX/LirTghHLVi
 Kvayg/8KInH4iT9NOeQx4UCAsXi2hZIwGWtZ5b9aMJEZqW+2RiP4djllh9ntvG3kWobc
 aONq/ov2jygeMQBr4WL9hjMCZLlBqz0r5XHPtghX61HPpd0wRbCXi+PZDBNyTy5f0f0F
 2oEaIvYEQtBHgAtRs1AQvdyoAPiGVeDSDtXisVJQ5UVgGDcvBmO7R7pGHa2ylTMC6WjA
 YCPr/RyH4860CIdA19uroeaAMzwZ9fuy8m2NoIDkKnmNhqF0QImWd0NSCSJvJM5uttYo
 x3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795531055; x=1796135855;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UEX4o8k+Gww6m4ANwU1ZxzsmQOir3DC/2QPeI+E/xCI=;
 b=hh+ueuOZu9gG45yekSk3vi67ysVeWmg5epS0l99Z+fumjGEZqnFWhmJ/jTxbwrWlWX
 HK3VmLLZWvyxn3TLRQSPe91WiaKBm7nIqvMI1JvnTneTKssncRT47HqeJcVE4Kwt1YY7
 I/ltRrV1ZEfdMus37fMpce+BGldqYzMl/Mo0kojI2VwvUHP60yL0aLtWOKlpjueU3DRa
 CxnQqV/Q14oHLs/wAauGTI6mjmr2RUsAcInj9r8VZe0iaqKj5EKbR9RKpXHBTAJw8JJ+
 daLVXyS+KeAdIM/3e6cVzlyAAS80t7CUW0hphqI8evFewp/Gq611lNxJGGc6kT8b/XXz
 ABwQ==
X-Gm-Message-State: APuU4Z8j095cFyRwP8nrt3zJX260NXWgqO8sQr/jAYK8nW853kYbavGl
 IjkMnwOWuBb3jnS7ur/O06QWNw2jvhyIhqSkBtqlWIdIaVh4mOAKFdDyl1/zeh2eEzfqCkBRQz7
 f8trN2S0co+/RlJJplHo/PxM85nBOqiW6tenk7L5CndvzugF62qALFXc/ck7IMGPVdmFGO4/Plj
 3onOZr0Q==
X-Gm-Gg: AZFdTZdG9FqIRAfeONs9HlwMUjgADl8wKGN8aCrM2Ai2baxnvSCP7JbHN4Gw/haZOk8
 RZpTqaX8oPckAF5Y/FxN5VzNNsoFTAL5pvCg919c5Q1OJIWiXL4IAWzKKzEnn705ymsqlojD2ly
 w5CeVNb6ZjmCvdzgtJvPMTJf3OpJ1EFzwHinvQf2eDEK9WZBkLCXHxDFYzfY6A0XMeeupj+H0fa
 PH41+Zo6B+6NUzyJU227GqSD2iDXExAqghVbTr5Ign30dEOAYkWHHX/l3JBY+kWVmmyqeaLyShE
 XkLkdX7m7b9O8mBTyfZ1K+dbPjEH/7WKyNRlULDXkZp9r4Y+S8A7lrJw98X4TcVx0Fdfnz6jST7
 nFVU4h8pvPf2VZ/2F9CuSHrzULtxhjJ3LUhU7rmgEQPOMQhkRWvAebOC5BAadG10q005VUw79Zf
 0FTgFbPFuCBH0MjyMmACswzkKmDjwPAprqikweYUT+dio1S7/1r6FoyteMkUv60rw8/5nE7N16U
 81+d4yIKUgDfOQfsXQKv6Kfnz4PIhMee/PGYDXt3yEcghrmIGbLVe9np6iuVBjtiU8wzAl1ruTk
 cOEni3TgOOGBDolw7uqq/6Exa654/vgX9wPHROKnhq8T7id5FOV/PxIC3IT0bHhXQc3KpqGS3Hy
 OcySOS2OIRBDsOqggYJk+TffTPFHQz048K1LExRePksHp8+ER8+Kx4NQMWPWDCVy6+pdSs6yEDH
 RIdevaN1dkv4L1SRA=
X-Received: by 2002:a05:6000:4704:b0:4a9:760f:183a with SMTP id
 ffacd0b85a97d-4abb400aef0mr29861947f8f.32.1795531055285; 
 Tue, 24 Nov 2026 06:37:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm32380044f8f.24.2026.11.24.06.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:37:34 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 14:37:34 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I512c18dd685885f5d9dc49b29021e22325827494
X-Gerrit-Change-Number: 2338
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2338?usp=email>
X-Gerrit-Commit: f482f8b57a61c32c7bc116cb01d43648eac60f88
References: <gerrit.1795531053000.I512c18dd685885f5d9dc49b29021e22325827494@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTMxMDUzMDAwLkk1MTJjMThkZDY4NTg4NWY1ZDlkYzQ5YjI5MDIxZTIyMzI1ODI3NDk0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f964894d70971266d6dcfa99c1678529de9f376-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVreQ-000000003vB-0rPF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: vlan: fix byte order
 in debug message and comment typos
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
Content-Type: multipart/mixed; boundary="===============5283595267212634935=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5283595267212634935==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B7a+0lIXkYE="; charset=UTF-8

--B7a+0lIXkYE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2338?usp=3Demail

to review the following change=2E
=


Change subject: vlan: fix byte order in debug message and comment typos
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

vlan: fix byt=
e order in debug message and comment typos

vlan_encapsulate() logged the i=
nner proto in network byte order;
print it with ntohs() and a 0x prefix lik=
e the other messages=2E

Its comment also claimed it is only used for VLAN_=
ONLY_TAGGED, but
it is called for VLAN_ALL too=2E

Change-Id: I512c18dd6858=
85f5d9dc49b29021e22325827494
Signed-off-by: Razvan Cojocaru <razvanc@mailbo=
x=2Eorg>
---
M src/openvpn/vlan=2Ec
1 file changed, 5 insertions(+), 5 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/38/2338/1

diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
ind=
ex d44dac1=2E=2E2ed1fe6 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn=
/vlan=2Ec
@@ -76,7 +76,7 @@
  *
  * For vlan_accept =3D=3D VLAN_ALL:
  *   =
Accepts both VLAN-tagged and untagged (or priority-tagged) frames and
- *  =
 and handles them as described above=2E
+ *   handles them as described abo=
ve=2E
  *
  * @param c   The global context=2E
  * @param buf The ethernet =
frame=2E
@@ -182,7 +182,7 @@
 /*
  * vlan_encapsulate - add 802=2E1q header=
 and set the context related VID
  *
- * Assumes vlan_accept =3D=3D VLAN_ON=
LY_TAGGED
+ * Assumes vlan_accept =3D=3D VLAN_ONLY_TAGGED or VLAN_ALL
  *
 =
 * @param c   The current context=2E
  * @param buf The ethernet frame to e=
ncapsulate=2E
@@ -249,8 +249,8 @@
     /* set the VID corresponding to the =
current context (client) */
     vlanhdr_set_vid(vlanhdr, c->options=2Evlan=
_pvid);
 
-    msg(D_VLAN_DEBUG, "tagging frame: vid %u (wrapping proto/len=
: %04x)", c->options=2Evlan_pvid,
-        vlanhdr->proto);
+    msg(D_VLAN=
_DEBUG, "tagging frame: vid %u (wrapping proto/len: 0x%04x)", c->options=2E=
vlan_pvid,
+        ntohs(vlanhdr->proto));
     return;
 
 drop:
@@ -289,7=
 +289,7 @@
     vid =3D vlanhdr_get_vid(vlanhdr);
     if (vid =3D=3D 0)
  =
   {
-        /* no vid: piority tagged only */
+        /* no vid: priorit=
y tagged only */
         return false;
     }
 

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2338?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I512c18dd685885f5d9dc49b29021e22325827494
G=
errit-Change-Number: 2338
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--B7a+0lIXkYE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2338?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">vlan: fix byte order in debug message and comment typos=
<br><br>vlan_encapsulate() logged the inner proto in network byte order;<br=
>print it with ntohs() and a 0x prefix like the other messages=2E<br><br>It=
s comment also claimed it is only used for VLAN_ONLY_TAGGED, but<br>it is c=
alled for VLAN_ALL too=2E<br><br>Change-Id: I512c18dd685885f5d9dc49b29021e2=
2325827494<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>---<br>M src/openvpn/vlan=2Ec<br>1 file changed, 5 insertions(+), 5 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/38/2338/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/vlan=
=2Ec b/src/openvpn/vlan=2Ec</span><br><span>index d44dac1=2E=2E2ed1fe6 1006=
44</span><br><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/ope=
nvpn/vlan=2Ec</span><br><span>@@ -76,7 +76,7 @@</span><br><span>  *</span><=
br><span>  * For vlan_accept =3D=3D VLAN_ALL:</span><br><span>  *   Accepts=
 both VLAN-tagged and untagged (or priority-tagged) frames and</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *   and handles them as described=
 above=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   handl=
es them as described above=2E</span><br><span>  *</span><br><span>  * @para=
m c   The global context=2E</span><br><span>  * @param buf The ethernet fra=
me=2E</span><br><span>@@ -182,7 +182,7 @@</span><br><span> /*</span><br><sp=
an>  * vlan_encapsulate - add 802=2E1q header and set the context related V=
ID</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Assumes vlan_accept =3D=3D VLAN_ONLY_TAGGED</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Assumes vlan_accept =3D=3D VLAN_ONLY_TAGGED =
or VLAN_ALL</span><br><span>  *</span><br><span>  * @param c   The current =
context=2E</span><br><span>  * @param buf The ethernet frame to encapsulate=
=2E</span><br><span>@@ -249,8 +249,8 @@</span><br><span>     /* set the VID=
 corresponding to the current context (client) */</span><br><span>     vlan=
hdr_set_vid(vlanhdr, c-&gt;options=2Evlan_pvid);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_VLAN_DEBUG, &quot;ta=
gging frame: vid %u (wrapping proto/len: %04x)&quot;, c-&gt;options=2Evlan_=
pvid,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        vlanhdr-=
&gt;proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_VLAN_DEBUG, &quot;tagging frame: vid %u (wrapping proto/len: 0x%04x)&quot=
;, c-&gt;options=2Evlan_pvid,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ntohs(vlanhdr-&gt;proto));</span><br><span>     return;</=
span><br><span> </span><br><span> drop:</span><br><span>@@ -289,7 +289,7 @@=
</span><br><span>     vid =3D vlanhdr_get_vid(vlanhdr);</span><br><span>   =
  if (vid =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* no vid: piority tagged only */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* no vid: priority tagg=
ed only */</span><br><span>         return false;</span><br><span>     }</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2338?usp=3Demail">change 2338</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2338?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I512c18dd685885f5d9dc49b29021e223258=
27494 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2338 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>

</body></html>
--B7a+0lIXkYE=--


--===============5283595267212634935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5283595267212634935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5283595267212634935==--


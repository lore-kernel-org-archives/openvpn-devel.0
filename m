Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF351606A327
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WNYlZYdo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g4uNWD87;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RSWkQY2p;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ht/Hjbcy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kvyhn/nYevNUtEJZIYz0s6E4VSTdlk7zqt9onMHqrOw=; b=WNYlZYdonJl4z4d5WPZYo+hwkF
	FRgNEO3FRS1Fsr8M6Goss+eTAQ6tcoqcU1LrI8Lo8Cw2LCd24jDuITUFVN6Njis1cxDL0WmeuWtVF
	K4Yq1XYIEriFjYinTDKbIH6pb6AQ2PFGIYDnALibYIkbDrSzqIuz00AK0zvoLtLFSoik=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHBl-000000004zg-3Xos;
	Tue, 03 Nov 2026 16:16:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHBk-000000004zZ-3kWu
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:16:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jvEXlFhZB6xuL1Ta0W8LTBztm7Y7JEKKfDRwwSZtUE8=; b=g4uNWD87myufKnLuC1KfENP/9O
 KxYPpsHSdUEYM3+xPvJ2XmKTLpcON4VvN6saw5yVTZecvaF8QXbEdripRhkoNI5TEyyztV6XD3sGK
 5+qNXYNSsojUPIdMcUtv9ESreA1pnQo5x/r+DBK3Vc8I32GFcvw+AuZ0oHzpYhpaaP7A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jvEXlFhZB6xuL1Ta0W8LTBztm7Y7JEKKfDRwwSZtUE8=; b=RSWkQY2p2oyVbppAuy2eVOHdhR
 mWJitJMfwq2r0gGSxoYfapEqscp4mJcfGauUFaRlQP3QO7Ee/k/q2ycLibJMYJpLXqQ0wVOGwsyKu
 q3XIhTrBDR3CFnWcEHcWWxa5QtiGU8RsZfJLR2td/QGR8ThgwGUvrQLddkI+RA700Wq4=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHBk-000000007ov-0mwF for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:16:44 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so2244289f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793722597; x=1794327397; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jvEXlFhZB6xuL1Ta0W8LTBztm7Y7JEKKfDRwwSZtUE8=;
 b=Ht/HjbcypbsInY6Nh5YC2ltmV2NW8jLLAPWKl4ss9+P7YlBbOuRGCDBNYJNWNw4NDH
 OsScOdd8ULkKTSnuZgHE2Vjnf0xi6l0cf0Gny0Zhc7wMywyQSCDdmFqvI22rd1RWqyiu
 tUCAZoG9JzgGsP9fV5uq3c7HERowtWzG3hTSFjy7sGyWuW5M7o52yLv3o8u1FtLAM1aj
 9CytR9qawAgZrWd3TwZyKBpS/rwmVOi4ZhDqf5fZBuFSmcE2cBCMrMhB09zyxnvuOWQZ
 sBz7xFJaqXIQZM1ziUJp2yIhwpoh4cRpshPB9pADamRkHrtfj+0W0B8r143o2EZM5BXM
 9tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722597; x=1794327397;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jvEXlFhZB6xuL1Ta0W8LTBztm7Y7JEKKfDRwwSZtUE8=;
 b=cDjFubIWySLZ8CZeOnU31KrweBTXlFDe8SuokhNighwsg1MWA3vtYgueKFDyvOldun
 80SfvrZlPm0MbqnzhS7jUviw7zT5vi1jVpxFXYPPJGFHp2D+BRv48IeV896uduCK1y5V
 jySdbwxfG5DMuk4l68pK0qVOKYSo1jTto21R0nmV8ELYPIHjGMBliz2Zvcfe1n49TBLw
 MS5P51CeNRRCLB7FBCiz2R+767aOEzqkizvZxdcWSViVkjnJSKjpReLnr6CXZG15H9JF
 rlsO5SfTeUK4uU/7qJyitkYL3Q2Sorm6Cnx+u4SknmOrF4nmMx5AM+NAOdb7uZ26o7hS
 8Z3w==
X-Gm-Message-State: APuU4Z/RT1drs7Y6tz4LybiRLq38Bh+UfwbnPEBcBpQhiECnLWowpgww
 6xpM0IB/hf5BvrNTVXMZXgPCFIKhNwUcJuA+qnxkwOubcfT7WzHq2H2t/1k+LKxRncBr6yt3jQR
 sMWGLUaQWibSB2I2lAxuo7efeX0JlitYnzLxlXTWqL0Ww8t2cP7iF6++I57ca49HpY71p5PTPEv
 pD2KfcfQ==
X-Gm-Gg: AYBFou3Ba+z4lTg1iqFT5H0D1DRwK1TpSQs3J5pgnvCDRgQV/m8wWwlQ/ypkxtXPAq7
 2QPkcQExL9J8fl9D9338krdM9RR9n2y6A+PIf5CVqcAy1X4OWbMRLCCeZLrXjQ5U37xi6F+psgv
 o9Yq5tkADVD//C5HGPkb0g1lL8ZT9yFVhbFFGE1NSmAGN9qu0FEBmjMbGkUPCEyRxKjOyKMj/0s
 n2NF5+9UyPnGPx1vISOLElcXBAKYu6UsQh9liFMrU7GOIWx2l4NyVuxU0t8neQorcg3IPJdEhqi
 ILZbJp86eHMrFTzwI65il2kKpJT8x3apjPe4a3btLwte7/HSrqHkt6DqdINwz+llPHJ4z9Kel8k
 z7uL1sAjeZMV3z+JlsupDpZK1ygQvYx3jXwS8BMg9EGafhD5Vde8/Zm6CgySJuEKgWTWJsy92OT
 SX45nu5mauEZiSBNI0vnoPSa7LI3RHihDxzJEGrknxO4/ZPyL4u4mRgJ1GfawST2ItVvmbSIVkX
 FcXa5FiygKTIfODgiSDhjU7kn28G/G0CENDRD+VUB6b8ugmco5j1kwA0hA+0M7uWEbs/DDGgCFS
 I7c7fCjAKlS13geKGkz7zALJ2u0bfJnbqTx8+Y8ONKG8XiLPEksrZuBUorAOklEVTqV7ZmStCnw
 AkwNond0TgnqA8BJ1iAIAVYQrvRmMz/on9pCZPknSgzghgQAPpST+zZtH+I7hg4fi1hiokdpnl2
 jsikOnjc+V9z2pE+o=
X-Received: by 2002:a05:6000:2892:b0:48d:eb44:650c with SMTP id
 ffacd0b85a97d-48e6e309f40mr30996343f8f.40.1793722597438; 
 Tue, 03 Nov 2026 08:16:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725a2sm24444872f8f.13.2026.11.03.08.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:16:36 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:16:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
X-Gerrit-Change-Number: 2102
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2102?usp=email>
X-Gerrit-Commit: 4deabc2e666a8930608fa85690651bf86a1ac5c1
In-Reply-To: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
References: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMjY1MDAwLkk1OTUzZGQ0ZTU4Y2JjZjhiMmM5YjM4YWRjYmU3NDcyMjNiYzRlYjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b06be010636b67251deb3e89cba2cea37df00e3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHBk-000000007ov-0mwF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: fix AIX IPv6
 route delete error message
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
Content-Type: multipart/mixed; boundary="===============5084516726544458423=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5084516726544458423==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gBech57VHok="; charset=UTF-8

--gBech57VHok=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2102?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: route: fix AIX IPv6 route=
 delete error message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

route: fix AIX IPv6 route delete error message

delete_route_ipv=
6() reported a failed delete as "route add command
failed"=2E

Broken since=
 b4b92ae5 ("implement adding/deleting routes on AIX, for
IPv4 and IPv6")=2E=


Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
Signed-off-by: Razva=
n Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Em=
uc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102
Messag=
e-Id: <20261103080936=2E8152-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=
=2Ekernel=2Eorg/openvpn-devel/20261103080936=2E8152-1-gert@greenie=2Emuc=2E=
de
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
route=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2102/2

diff --git a/s=
rc/openvpn/route=2Ec b/src/openvpn/route=2Ec
index e8de2d5=2E=2E152d0d2 100=
644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2309,7 +230=
9,7 @@
 
     argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, n=
etwork, r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
-    openvpn_=
execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+    ope=
nvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete command failed");
=
 
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Deleting routes o=
n Android is not possible/not "

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2102?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
Gerrit-Change-Nu=
mber: 2102
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--gBech57VHok=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2102?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">rou=
te: fix AIX IPv6 route delete error message<br><br>delete_route_ipv6() repo=
rted a failed delete as &quot;route add command<br>failed&quot;=2E<br><br>B=
roken since b4b92ae5 (&quot;implement adding/deleting routes on AIX, for<br=
>IPv4 and IPv6&quot;)=2E<br><br>Change-Id: I5953dd4e58cbcf8b2c9b38adcbe7472=
23bc4eb6b<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<b=
r>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102<br>Message-Id: &lt;20261103080=
936=2E8152-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eor=
g/openvpn-devel/20261103080936=2E8152-1-gert@greenie=2Emuc=2Ede<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/route=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/02/2102/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index e8de2d5=2E=2E152d0d2 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -2309,7 +2309,7 @@</span><br><span> </span><br><span>     argv_=
printf(&amp;argv, &quot;%s delete -inet6 %s/%d %s&quot;, ROUTE_PATH, networ=
k, r6-&gt;netbits, gateway);</span><br><span>     argv_msg(D_ROUTE, &amp;ar=
gv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execv=
e_check(&amp;argv, es, 0, &quot;ERROR: AIX route add command failed&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve_=
check(&amp;argv, es, 0, &quot;ERROR: AIX route delete command failed&quot;)=
;</span><br><span> </span><br><span> #elif defined(TARGET_ANDROID)</span><b=
r><span>     msg(D_ROUTE_DEBUG, &quot;Deleting routes on Android is not pos=
sible/not &quot;</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Demail">change 2102</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5953dd4e58cb=
cf8b2c9b38adcbe747223bc4eb6b </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2102 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--gBech57VHok=--


--===============5084516726544458423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5084516726544458423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5084516726544458423==--


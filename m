Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51654606A8C7
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b5HLdtzE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QMye1F0A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jU+CPqBb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dmsXYL5r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=lRUKHjF2VnVLiCjIJFMJAuebSkZqEx6bd4lErPLSOR0=; b=b5HLdtzEvSkhaMr6/Ci1axuwhI
	kdu+lv1ZYJgi3b3DADme6NJiso7NU3PkpxtUeaoEuzmW9S5w7McHkwO849L72GL1fnUnMSMamD3TM
	gA49B+rOSL/cY64F5ljYQRZKRgU/WC2a6R5lu5Ik3V/zTUDsoYY22fTKTBPqX7AjOOLE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUVTT-000000006g2-06cV;
	Fri, 20 Nov 2026 20:44:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUVTS-000000006fv-0UZI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:44:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DAZe5BcarsZgxsWTGZVIo9bvz0Oi4RuAXUbsjEkphMM=; b=QMye1F0APbT6rWteNBjzrxbcZI
 EpGCjMpvoptLzWmJU3w9V1c8e3xuAzDQ2MlNROvH+fkVBAbHibrki3zHx5+dq33IBq2Wenrdplt1v
 AAh6yl9UhuSUiPtkU3Dnq/erGuVO0QW01fIF+PlFH4mGBs2e45wmSu/Wgmy4qTU8Bpu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DAZe5BcarsZgxsWTGZVIo9bvz0Oi4RuAXUbsjEkphMM=; b=jU+CPqBbWvsGhgfOHI1rPjK2cI
 zqWgH0eciLGe56Ay2i+7KBRnGVmTqrPNsijS8UbgninyU+ej444uo2H8C/R/g8IS3V2xKs7DJ6SpQ
 QkRSILNyo810gG7IImoa4/c8fz7Z5fzRgQNctURjS2WQ7OSCSbdMSGAGIYQAH7X3/9/Y=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUVTQ-000000003TG-2Ets for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:44:46 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so848503f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 12:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795207478; x=1795812278; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DAZe5BcarsZgxsWTGZVIo9bvz0Oi4RuAXUbsjEkphMM=;
 b=dmsXYL5rulE4t62+CBn/06haj3wp4mBlWsLHbhMiuKdUVzE5Q10HV8hw5MTQiE5DLe
 xCCp2bDR3L5f8WAncZb8Y86CsIljJJ145yaIqexFVkK0904P25CPgJUMgmid7PPUzb1M
 ZqFacWoRFXrsZhhUwMgqd79JknFlAb1+SkKY7Y5UCO42HDd75T71zizyJFshuwI9KlIW
 GDf9SfNa5yRuWAF6iqLPLiGH45d1b1DfyAqXB8BEdByrQVtcG4+tGBptfXN7gKdIahra
 Dj0Ur5h5wMRs0Pi9KAgnr5iH28CdrNx5GPfJVlPobCQadei++tCFqnQMG6R4cr0u1FRs
 Z/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795207478; x=1795812278;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DAZe5BcarsZgxsWTGZVIo9bvz0Oi4RuAXUbsjEkphMM=;
 b=1Y5beqgbXrProvgmmDdOOeyMiGUagHSN3L+leTk3v1GY5lsA7zfHLNqCrmnPHrSZzh
 T9r0ySr6FjbZ5Z7aJ38SnZODOrRSJjnQW0ioyZEWlkX26Nu08pwN+7ff/xt5Ft88+14K
 LALAWQHS7WxKl49JmZNz0dvoEpZqEBm7aM0XOXlljU6MdgBCzfAw13wWaJPYVaovQmc7
 VylO87+eG8ZVacdnUhKTXsM+jPBk7XsDkrThI6H1Zz/Jc6lyD8NDWAOk3ianb29AbX8+
 /qR446nOC2wN6B4gn7YnqASU2C1GAF7I1mUdunWP/w2j/VbWS8GnxehVPJ3Y8xp3chwc
 e4jw==
X-Gm-Message-State: APuU4Z/ZH6md3tOlCfPJR9sDE9qYZMD86zxBU6JAdosUEaP7g4qvArBs
 dYANGGYYUqKvj+EgRv/2YPH0Ylqq7TmIdZJSmPQ8FIvVYZgL2lW++MsAu/LqZ1ID5YbE/qaTwCC
 wYDW6MGME07dCCjkPxM7fWhXzV3pK8et+1/+ktN9etWQq02HqgsqXuRPse/ld3XVIxZoMNdcmSm
 57HZJwTw==
X-Gm-Gg: AZFdTZebSaLcWwMUrft2Ey1CtNjatNFR+10wj+GnLZFaNuBAT5tWkaBSW2Rq6ccUsNI
 qyVYa1ua39Ycqn7GiZrC3XWaolX4dlFIIm4UpY+OJhdDBVfW4zVd/uqwbNNCgUbc4H1wskxhj8Y
 gPwYRhq2wAxnxD/xyQ2r6oPNH48QAtKtQ4myy1rfEeBDNJQ91FgsCutisF42LSEME6mEeh9/f+L
 bBOilMfJLgtIe/oWObvXSpB8OLVH0wzgC44k1nBr8OD5DcJaFLSlrqMYtDypQ8QjFEe+kUoFYaS
 6j0VDF+IUHgNGTJBpHOZsptDh+vYQPikxIQ+2MFcOEsvlSkbTlPhdHnh4YdifLpPTOEGRHj6qje
 m5na1m7cPUzjMTatyYreiKbR2RYDliBqbt89PnpjwDYQamWn2rqweqOLJ2EEJFB93Qflnhk+MBJ
 hAyV1mkztFsOtA/rKZgU2HLT72l8iIRWCRdZxw3B04uDybQDV+jk76KA2nll6PESU43p7t4fYxc
 czCcuoUUrJXQxCv709q+58vJTF1yjLVS344ktZFH381JTP9mZzGK1m0SowpA3+u1ByHlwTL5HVF
 vcmnvRoJy2YICq5wjNRihH9lMqmvJ3qWTDG6oDS7iMrDTe2LFWzfF3d2ezAzgGC14fRw1gCPHme
 1Zo+GfvYF0kqtnhh2hr1pG6cYYphsfEISXzDKwnkkiwaKEXGwW5g5seZPqP0rXCdA53i2dzWhgn
 AcYzXun65rjF1ZjmA=
X-Received: by 2002:a05:6000:2c04:b0:4ad:2699:74ec with SMTP id
 ffacd0b85a97d-4ad269975e8mr5871026f8f.39.1795207477823; 
 Fri, 20 Nov 2026 12:44:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm7534566f8f.40.2026.11.20.12.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:44:37 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 20:44:37 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c
X-Gerrit-Change-Number: 2235
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2235?usp=email>
X-Gerrit-Commit: a7e49fa31c61faca1f46551d6b35da4f85ff61e3
References: <gerrit.1795207472000.Id346f35f6ce371b177af7454cd73d3eeccb8ed6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLklkMzQ2ZjM1ZjZjZTM3MWIxNzdhZjc0NTRjZDczZDNlZWNjYjhlZDZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <851fb061ff23485682b980ecf4db01071078146d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUVTQ-000000003TG-2Ets
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 NRPT exclude data if one address family fails
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
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5337615036916685829=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5337615036916685829==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CTpN31wmYIk="; charset=UTF-8

--CTpN31wmYIk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2235?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: keep NRPT exclude data if one address family=
 fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: keep NRPT exclude data if one address family fails

GetNrptExclude=
Data() skipped an interface completely if reading its
IPv4 or IPv6 name ser=
vers error'd, even if the other address family
had servers=2E

Use the name=
 servers that could be read instead=2E

Change-Id: Id346f35f6ce371b177af745=
4cd73d3eeccb8ed6c
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
=
---
M src/openvpnserv/interactive=2Ec
1 file changed, 20 insertions(+), 14 =
deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/35/2235/1

diff --git a/src/openvpnserv/interactive=2Ec b/src/openv=
pnserv/interactive=2Ec
index 32b1688=2E=2E7ea88a1 100644
--- a/src/openvpns=
erv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2580,11 +2580=
,15 @@
         /* Get the IPv4 DNS servers */
         DWORD v4_addrs_size=
 =3D sizeof(data[0]=2Eaddresses);
         err =3D GetItfDnsServersV4(v4_it=
f, data[i]=2Eaddresses, &v4_addrs_size);
-        if (err && err !=3D ERROR=
_FILE_NOT_FOUND)
+        if (err)
         {
-            MsgToEventLog(M_=
SYSERR, L"%S: could not read interface %s v4 name servers (%ld)",
-        =
                  __func__, itf_guid, err);
-            goto next_itf;
+  =
          if (err !=3D ERROR_FILE_NOT_FOUND)
+            {
+              =
  MsgToEventLog(M_SYSERR, L"%S: could not read interface %s v4 name servers=
 (%ld)",
+                              __func__, itf_guid, err);
+        =
    }
+            data[i]=2Eaddresses[0] =3D '\0';
+            v4_addrs_s=
ize =3D 0;
         }
 
         /* Get the IPv6 DNS servers, if there's sp=
ace left */
@@ -2593,19 +2597,21 @@
         if (v6_addrs_size > NRPT_ADDR_=
SIZE)
         {
             HKEY v6_itf;
-            if (RegOpenKeyExW(v=
6_itfs, itf_guid, 0, KEY_READ, &v6_itf) !=3D NO_ERROR)
+            err =3D=
 RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &v6_itf);
+            if (!=
err)
             {
-                MsgToEventLog(M_SYSERR, L"%S: could no=
t open interface %s v6 registry key",
-                              __func=
__, itf_guid);
-                goto next_itf;
+                err =3D Get=
ItfDnsServersV6(v6_itf, v6_addrs, &v6_addrs_size);
+                RegClos=
eKey(v6_itf);
             }
-            err =3D GetItfDnsServersV6(v6_itf=
, v6_addrs, &v6_addrs_size);
-            RegCloseKey(v6_itf);
-           =
 if (err && err !=3D ERROR_FILE_NOT_FOUND)
+            if (err)
          =
   {
-                MsgToEventLog(M_SYSERR, L"%S: could not read interfac=
e %s v6 name servers (%ld)",
-                              __func__, itf_g=
uid, err);
-                goto next_itf;
+                if (err !=3D ER=
ROR_FILE_NOT_FOUND)
+                {
+                    MsgToEventLog(M=
_SYSERR, L"%S: could not read interface %s v6 name servers (%ld)",
+       =
                           __func__, itf_guid, err);
+                }
+  =
              v6_addrs[0] =3D '\0';
+                v6_addrs_size =3D 0;
 =
            }
             if (v4_addrs_size && v6_addrs_size)
            =
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id346f35f6ce3=
71b177af7454cd73d3eeccb8ed6c
Gerrit-Change-Number: 2235
Gerrit-PatchSet: 1
=
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--CTpN31wmYIk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: keep NRPT exclude data if one address family fails<b=
r><br>GetNrptExcludeData() skipped an interface completely if reading its<b=
r>IPv4 or IPv6 name servers error&#39;d, even if the other address family<b=
r>had servers=2E<br><br>Use the name servers that could be read instead=2E<=
br><br>Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c<br>Signed-off-b=
y: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpns=
erv/interactive=2Ec<br>1 file changed, 20 insertions(+), 14 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/35/2235/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 32b1688=2E=2E7=
ea88a1 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><=
br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2580,11 =
+2580,15 @@</span><br><span>         /* Get the IPv4 DNS servers */</span><=
br><span>         DWORD v4_addrs_size =3D sizeof(data[0]=2Eaddresses);</spa=
n><br><span>         err =3D GetItfDnsServersV4(v4_itf, data[i]=2Eaddresses=
, &amp;v4_addrs_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (err &amp;&amp; err !=3D ERROR_FILE_NOT_FOUND)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (err)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Ms=
gToEventLog(M_SYSERR, L&quot;%S: could not read interface %s v4 name server=
s (%ld)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                   __func__, itf_guid, err);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            goto next_itf;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (err !=3D ERROR_FILE_NOT_FOUND=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                MsgToEve=
ntLog(M_SYSERR, L&quot;%S: could not read interface %s v4 name servers (%ld=
)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                   __func__, itf_guid, err);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            data[i]=2Eaddresses[0] =3D &#39;\0&#39;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            v4_addrs_si=
ze =3D 0;</span><br><span>         }</span><br><span> </span><br><span>    =
     /* Get the IPv6 DNS servers, if there&#39;s space left */</span><br><s=
pan>@@ -2593,19 +2597,21 @@</span><br><span>         if (v6_addrs_size &gt;=
 NRPT_ADDR_SIZE)</span><br><span>         {</span><br><span>             HK=
EY v6_itf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &amp;v6_itf) !=3D NO_ERR=
OR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            err =
=3D RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &amp;v6_itf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (!err)</span><br=
><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                MsgToEventLog(M_SYSERR, L&quot;%S: could not open interface=
 %s v6 registry key&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                              __func__, itf_guid);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                goto next_itf;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                err =3D GetItf=
DnsServersV6(v6_itf, v6_addrs, &amp;v6_addrs_size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                RegCloseKey(v6_itf);</spa=
n><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            err =3D GetItfDnsServersV6(v6_itf, v6_addrs, &amp;v6_addrs=
_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Re=
gCloseKey(v6_itf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (err &amp;&amp; err !=3D ERROR_FILE_NOT_FOUND)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (err)</span><br><span=
>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          MsgToEventLog(M_SYSERR, L&quot;%S: could not read interface %s v6=
 name servers (%ld)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                              __func__, itf_guid, err);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                goto next_itf;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (err !=
=3D ERROR_FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    MsgToEventLog(M_SYSERR, L&quot;%S: could not read i=
nterface %s v6 name servers (%ld)&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                  __func__, itf_guid, =
err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
v6_addrs[0] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                v6_addrs_size =3D 0;</span><br><span>            =
 }</span><br><span>             if (v4_addrs_size &amp;&amp; v6_addrs_size)=
</span><br><span>             {</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail">change 223=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Id346f35f6ce371b177af7454cd73d3eeccb8ed6c </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2235 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;=
heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--CTpN31wmYIk=--


--===============5337615036916685829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5337615036916685829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5337615036916685829==--


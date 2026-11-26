Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600A606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DCBpdebq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U8o5EpUf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kiSo5WOs;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JUJVdsUm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=73BLT8SSyefA+WkIli6mK8ppuqT0i/ryWIDlzZOE1qc=; b=DCBpdebqSyLwrTAvdBHtEv8Kxv
	b9kvOWV2lc1nSHxkSK2q9n5Ppg6feydAbef3h+YpTs0D+0N/EXHRGHRKEMee/EYAbFbFWnjIK7wgV
	z6lydZNae5sXcOZTmKEfOitPeeooS7IBTZK2QEWE6FXVo1/5GRB03r4KdhRcNFmdgBb0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWYPS-0000000087u-1OOm;
	Thu, 26 Nov 2026 12:17:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWYPP-0000000087m-2t7n
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Cejpe6sR+KFesQ//JEbgNvo7Ir5wNiz+bMz3xZnJ24=; b=U8o5EpUf9ihJmFQJPlVIY8Ifwx
 mzIJw8KXyOM98VuiV6wheaLc8iggDd4rwl1h861EQc2iIW2w9uZy/b81zBHR5D53TH3MobEWTEiLK
 bmehoWtBfwgAVfSiUyyDr/Emf7Xes7gUmmXT7bDuTKQJgPt3M7rbQRffmVsICdp+srNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Cejpe6sR+KFesQ//JEbgNvo7Ir5wNiz+bMz3xZnJ24=; b=kiSo5WOsTAigjKFH9KE++4e82v
 3J6ugCKXSEU1kGn0sgdcl2kxWK2glApGCYb9GLn7MzLDMYF9g1aiJ8P/5bKQf6f03GDVjEZweO2j8
 Cut2FfWPn9qyj48fsjHqiavk479O5jMcrR/u2ONcXmLke1aPBiuTadaZwGcRlVk2iG0c=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWYPN-000000001xk-40lU for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:17:03 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so4516169f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 04:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795695415; x=1796300215; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Cejpe6sR+KFesQ//JEbgNvo7Ir5wNiz+bMz3xZnJ24=;
 b=JUJVdsUmB4IEYF1G9+dHPFJJqxijYd6+lN1e/Ghnrrt35gMvRvGKmIqLYARvatBpvy
 Ixc/C2lQzLXwuSd24GgE3PsBIaNgiWSsjPZftOGxKErX8lbO7w7ptrkHco0j2Uh09TyG
 42Y/Dw6Jykp1j1CyVDJ6lbajhjVVOfkeXaCGpfw9CMDGzeK9KWcI2YVfxXWKd2tB1DDP
 ceXWv0XQp/QRE3z2sDtimFAWXCgNEwVCLGPJ6QvrNommqT/vwVPM3m1GfHaLBssI9JWi
 NpCls7aUlH/3TCeX9oFXtUSS2NFHFzx5acW6HgXPsEWiBRqb2Dsm6+TaYcUquOpT4BlU
 HznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795695415; x=1796300215;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1Cejpe6sR+KFesQ//JEbgNvo7Ir5wNiz+bMz3xZnJ24=;
 b=dRDjgU5Ch2cAflASuRBHJ310gCBzB6GkzKivpTDpGtPFwQTlCks1iZ0vKHU7sB+X1Z
 qUG9LaWRqUKXtQzTi6AMFR3im7c5I4XJRgJe+itA523XqaLIHmYys2OkmJaLyqAW1svu
 juDKtAAtil6hMmP7bTELKH8sna0H/NcFJrdKIE8c/FwZvrFvcwQfU8YNkT2O4Sy3ew4Z
 ZZqEptIYifNxIYRgkboT+hUuo/iu3RY0oeBLOUpkOuuGubXoFpNxzzNFeXWz5RTBWfD2
 +c/mtD7FklKe1uNxb3INU0GbMRq7LSGwE5svtnxz1nMAvT3yLOk5EdWvzFqU96AOk90X
 C06g==
X-Gm-Message-State: APuU4Z/jyf2/KmJT5y4++Cf4IZPMAlgwuUO52sdIOP2j2sHEcmIJXg5j
 YRIGlsNDlB4vxa/hldDYTp6vlEeYfX2HemWLr3n+fdp03kWFsxedjKsS25M6ojBEuueBmKXZh4I
 yZxlLlH+MxGPx+r7WI9+ByMay4zuR+sBNaPEBg6Qi2OvXrJGLBE3Zkzfz8auOUStiXa95
X-Gm-Gg: AZFdTZeQKX3xVDGIQBafz/pECj24X2X9wHzdacRpZUzsv8Dkulpj1lqIrvyWbUuTUeU
 9hhGfM8LcUpSrvzRp14k5vIB7Fv8IvTGEeeThPB+R6xeQVz8ZZofDMUVpi+fZJV9p4SFAGl2fgO
 8UO7SPIIHhkfJzym4OGneQwUpFzLy3oZq1CQfmee8v2IXjJKQYpfe5JRwZjuuz7D1IfWMz7B3Gv
 qYb/4GjnAyCxVKpxCKY5VwRifT9Bzs+vYvGRoXFv9j9lNBk3/eVq/wFDRdA9VXLUQz4K7Oi3RPf
 cf3ZEcj5pkmEpbYte6JRUAe++LJ1TGPs7wpvdxB0M08X0VdVdTdPwedF5lg/YkKFmNlaaBKlQFY
 nRZh3S8QRIjj6Xla2U63l1DkuO9hHp1Dag7zzZHsyl4tMw2/N5C1gtvUIrq8CDKiKVTjPtV5mz4
 i3Kz9OFCkQ+4LJrn5YWsusxfqilKCMn8v44uPR2NhLrK8YcwojaSzpv2rKiKRBcSgfEXW1iO6eL
 olaJ6EhVxovS9agTilrsisvRCoTVZ7kOIdjFl2YZNF2+FbBh9v2lIX3NYmXmP0USOdV9OkRqlJI
 jqjcyUY5694oaXhiqp/hW4wlB8KMkgleL99FeoyhUr9+s6Vlk5hvqDjgnanVx7Oy3MG+kJAkcF/
 irJMIKQiDOigaBPX0/L2lHhtM72GX55iKK9JG78S1wcVQi0Q7/Vnmbre499NuCP6/IySWJXTgKT
 bhaidpXzc6iojitoE=
X-Received: by 2002:a5d:6f0c:0:b0:48d:db77:d124 with SMTP id
 ffacd0b85a97d-4abad5ac893mr38198424f8f.6.1795695415284; 
 Thu, 26 Nov 2026 04:16:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad644140b5sm36997393f8f.17.2026.11.26.04.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 04:16:54 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 12:16:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
X-Gerrit-Change-Number: 2352
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2352?usp=email>
X-Gerrit-Commit: fd5b0a0a662a9b6c5559952ae03c331790e02225
In-Reply-To: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkxMDU5MDAwLkliYzU4YjljMzAyOWZmZWE0Zjg3MDkzMTc4Y2Y1MmJiYjQ2ZjZkODM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3529755c88bfb6cc729133ded4db86e13d8982d7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWYPN-000000001xk-40lU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: return early
 from man_check_for_signals() if a signal is set
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3391018287144605155=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3391018287144605155==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZSYfrfuKsnA="; charset=UTF-8

--ZSYfrfuKsnA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit
=

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail

to look a=
t the new patch set (#2)=2E


Change subject: manage: return early from man=
_check_for_signals() if a signal is set
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: return early from man_check_for_signal=
s() if a signal is set

Four standalone event loops checked signal_received=
, called
man_check_for_signals() if it was unset, then checked it again=2E
=
Make man_check_for_signals() return true right away when a signal
is alread=
y set, so each loop needs a single call=2E

Change-Id: Ibc58b9c3029ffea4f87=
093178cf52bbb46f6d837
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
---
M src/openvpn/manage=2Ec
1 file changed, 8 insertions(+), 20 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/5=
2/2352/2

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
inde=
x bbf454a=2E=2E96428c0 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvp=
n/manage=2Ec
@@ -3444,6 +3444,10 @@
 {
     if (signal_received)
     {
+  =
      if (*signal_received)
+        {
+            return true;
+        }=

         get_signal(signal_received);
         if (*signal_received)
     =
    {
@@ -3620,11 +3624,7 @@
         do
         {
             man_standa=
lone_event_loop(man, &signal_received, expire);
-            if (!signal_re=
ceived)
-            {
-                man_check_for_signals(&signal_recei=
ved);
-            }
-            if (signal_received)
+            if (man=
_check_for_signals(&signal_received))
             {
                 retur=
n;
             }
@@ -3762,11 +3762,7 @@
             do
             {
   =
              man_standalone_event_loop(man, &signal_received, 0);
-       =
         if (!signal_received)
-                {
-                    man_=
check_for_signals(&signal_received);
-                }
-                if=
 (signal_received)
+                if (man_check_for_signals(&signal_recei=
ved))
                 {
                     ret =3D false;
              =
       break;
@@ -3847,11 +3843,7 @@
         do
         {
             ma=
n_standalone_event_loop(man, &signal_received, 0);
-            if (!signal=
_received)
-            {
-                man_check_for_signals(&signal_re=
ceived);
-            }
-            if (signal_received)
+            if (=
man_check_for_signals(&signal_received))
             {
                 go=
to done;
             }
@@ -3990,11 +3982,7 @@
             do
            =
 {
                 man_standalone_event_loop(man, &signal_received, 0);
- =
               if (!signal_received)
-                {
-                  =
  man_check_for_signals(&signal_received);
-                }
-            =
    if (signal_received)
+                if (man_check_for_signals(&signal=
_received))
                 {
                     break;
                =
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc58b9c302=
9ffea4f87093178cf52bbb46f6d837
Gerrit-Change-Number: 2352
Gerrit-PatchSet: =
2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ZSYfrfuKsnA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83=
zvan Cojocaru <strong>uploaded patch set #2</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">manage: return early from man_check_for_sig=
nals() if a signal is set<br><br>Four standalone event loops checked signal=
_received, called<br>man_check_for_signals() if it was unset, then checked =
it again=2E<br>Make man_check_for_signals() return true right away when a s=
ignal<br>is already set, so each loop needs a single call=2E<br><br>Change-=
Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 =
file changed, 8 insertions(+), 20 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/2352/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><=
br><span>index bbf454a=2E=2E96428c0 100644</span><br><span>--- a/src/openvp=
n/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@=
@ -3444,6 +3444,10 @@</span><br><span> {</span><br><span>     if (signal_re=
ceived)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (*signal_received)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span>         get_signal(signal_receiv=
ed);</span><br><span>         if (*signal_received)</span><br><span>       =
  {</span><br><span>@@ -3620,11 +3624,7 @@</span><br><span>         do</spa=
n><br><span>         {</span><br><span>             man_standalone_event_lo=
op(man, &amp;signal_received, expire);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (!signal_received)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                man_check_for_signals(&amp;signal_rece=
ived);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (signal_=
received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (man_check_for_signals(&amp;signal_received))</span><br><span>        =
     {</span><br><span>                 return;</span><br><span>           =
  }</span><br><span>@@ -3762,11 +3762,7 @@</span><br><span>             do<=
/span><br><span>             {</span><br><span>                 man_standal=
one_event_loop(man, &amp;signal_received, 0);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                if (!signal_received)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    man_check_for_signa=
ls(&amp;signal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (signal_received)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (man_check_for_signals(&amp;signal_rece=
ived))</span><br><span>                 {</span><br><span>                 =
    ret =3D false;</span><br><span>                     break;</span><br><s=
pan>@@ -3847,11 +3843,7 @@</span><br><span>         do</span><br><span>    =
     {</span><br><span>             man_standalone_event_loop(man, &amp;sig=
nal_received, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (!signal_received)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                man_check_for_signals(&amp;signal_received);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (signal_received)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (man_check_for_=
signals(&amp;signal_received))</span><br><span>             {</span><br><sp=
an>                 goto done;</span><br><span>             }</span><br><sp=
an>@@ -3990,11 +3982,7 @@</span><br><span>             do</span><br><span> =
            {</span><br><span>                 man_standalone_event_loop(ma=
n, &amp;signal_received, 0);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (!signal_received)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    man_check_for_signals(&amp;signal_re=
ceived);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                i=
f (signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (man_check_for_signals(&amp;signal_received))</span><br>=
<span>                 {</span><br><span>                     break;</span>=
<br><span>                 }</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail">change 2352</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib=
c58b9c3029ffea4f87093178cf52bbb46f6d837 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2352 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ZSYfrfuKsnA=--


--===============3391018287144605155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3391018287144605155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3391018287144605155==--


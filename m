Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A26EC43602
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUcJ2YEnxqQFlKJLrrV6dcGU5FYhW6poopkpzWVhQPQ=; b=JLhXzxEBROahpY8KPQYDh8Gg3m
	LP3vEUJ1YlZGEVDNj2pW7i2hX8u1fTOORHQCoO/q7TZwhaFLAviTdSObBr+fSu2hk8KANuaTx+W5l
	h2RyLNxHjJrVZHCJZdCebbvehhLkgi5M2jPRvV79koMGm/qWjYeyfj6zNvuySC/jYawI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfDtP-0002r2-6Z;
	Thu, 02 Jul 2026 09:39:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfDtN-0002qu-OE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jA6t2llVZ4a5mSylDO0HIkSB0PHdUYOHcoSOxaMeCII=; b=NWuqKjakywJYgO722xemh8tokw
 zUoKvCft+jNtLF/0u88FtQFDcUyG849wa6LDtnyAeHbe31MZYSQL5fksaB3LdnTwZ7hNOHwVPfaey
 8uaRryiuAQ+2DVktUuhAhL/ljU70CqKOHj8Z6yZhZm790ldwUgXJf/LIVklQ1EKvSHjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jA6t2llVZ4a5mSylDO0HIkSB0PHdUYOHcoSOxaMeCII=; b=f
 345iqP3j98QeMFJF2b6kx5zX/1LbqpQmZWCRcQI6juCoAuvLw/x9bgAMldsTweR8yLzmy88EbGbnr
 XWFgOVV3fOYi+lKm/CnG2RLeo+yPM0z8QiCIYhsn6A/6XDr469IdxGEcohG/J6Xt/aqid5FZC5+zW
 hw7eVBTC4J5dxlDA=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfDtM-0005n6-IJ for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:39:33 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so11778265e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782985161; x=1783589961; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jA6t2llVZ4a5mSylDO0HIkSB0PHdUYOHcoSOxaMeCII=;
 b=daCDeD8uND50JPl5VhDVMFPp4pqn19AtytrXKdvrKQYOiTKXxb50SEgIZrkhMdU079
 OKWgQi8QkUKgbjcWyY0xvDw/eKZI2SMIeCMq+t+1wNHXzhred0oTbzbI7880R2XbiDeb
 4nm9QrtzQnCmoWTMv18zD657Yk/eO0Fs4HucLfnjPDp3amfEaioIkR4dXpGf4uhAZAsO
 FQNL65GaiLjST1sN+TuV6powj4BB3qv5hd/DFSzy4KH6Lz7Q2SrowfLwvMz/ApDbdOd/
 C6xi75zc4rt+KPw/BAjPwDDa3vlf0YT2Gb1AxcnCMjB6ILVlqR0oDGSancu8yTqOgUCh
 cX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985161; x=1783589961;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jA6t2llVZ4a5mSylDO0HIkSB0PHdUYOHcoSOxaMeCII=;
 b=PTqJQDKMJicENht7pgAysH2GgDlb1k4AUqPduiS3sk70srEML80ocdiBIWPLIzrHtT
 nUWu9RbVWU0v9HglDfgdHtAJ80V4V3RWtDhClE+vNzNvumbH7WVfzAmTesvXJKwvzChv
 MKSXnz6G0gUw2X5tiv2hB1qQhKdTiw15PHUp2phNFFpRFjx7cj6UrrjrC8veVrfpMlDC
 NLTOkISb0l4gILrjzIeXPyPMDH5SSzTlPvUE+RJSHK7hBCPtBQqA0DPjLFGlEwgp6w6O
 Fvq9mO0xrC9z8SX8Z4gK9tnDqh3E1sd3iYxP0EUFkA6MyfKM/7VKZY6zmqYF/5FRfN1Y
 p8fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/y/Awt7IegYoUPMK7tzCaKq0SqSrNENW3EsEBVGvBXs0Qjy9rw+tv/3Qj9YfTsyTi9T4VaEizV4K3vpZi8@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxrC7dseeFcvwrxba2+ittOVTL6fvdK5Rrse5xVen6K7yRnOkZA
 MNTcqzI7dgorr404GebAVB02JQ5Ehnd5e1D9gxl19yxvSpPUEmzhgpbA8fcTs/JfF6pUzPwwulx
 o/onTRB9Nc08mO69doRmgaGjBj6iW5/O+lgJtEsh4p1TKMMQzoanEqzFkuEW4IkRuRRBf
X-Gm-Gg: AfdE7cnE+yckVD8qOZJTYABA1B7JZPcb5pkHt1IQwX07DQdm7kuLNqQIETgkoENW5yS
 a7leJvf1sxutpudtIQc1Yxeu7N72L1D6y36vHAMa7f6mMxfz39nuMRy+k0MbS3QePs2TRO9yFT9
 d/3Xk3578MRCo4mskuXhLwPdksfo/opd5SPXu0sr8tZ5FTqs6N3vQ7esZTEePXA/8oOQHA+EkbA
 WIxMFAJAugLAM483W7FiqY0Oyr13tcOVBcz3S5oxC1Zn7DKnnJUWz6T4E5qPuZgRco9CmACHpHB
 3c8jUdSikXN56EtSpgpna9CKoMD7WA1apzkjRNLQj+C7qyQR5JO6tjvAxxgNYqJrdhwKEpmubJn
 IargAaPTkZkTBaHOum17iPADjKA0wpgCu3+DEI99tah5nlw8WWUi9NZ1hXPf3RL1rlTkdQWx2Ju
 WBEA6WgYcP1QPZSP5vWdouh1uxSaJ1yvN180oLokv3s/VoR6hVMHkpFJWlS4khFtur9HFbvFCpR
 +TYTuzhQgSDd8gq4/JuUeQ00A55W5B1d00BJuez1O/l4F6+tfBY+LaK1pC6zN/dO6S7nukpnzEH
 kRo=
X-Received: by 2002:a05:600c:6692:b0:493:bb6b:5bda with SMTP id
 5b1f17b1804b1-493c2b983b8mr73738185e9.29.1782985161419; 
 Thu, 02 Jul 2026 02:39:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm98175855e9.2.2026.07.02.02.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:39:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 09:39:20 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d
X-Gerrit-Change-Number: 1761
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1761?usp=email>
X-Gerrit-Commit: 7141f625c6114e08e40696464bfc36d5c5743683
In-Reply-To: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
References: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTIxNDk2MDAwLkliYTU3N2Q2NjJiMzg5ZGU1MzliODEwMzQ3MzVlNDM3MTk5Y2I0OTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <594c79781a6d3757a3e07550273641d46f19864e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfDtM-0005n6-IJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_tls_crypt: Fix
 issue with temp file name on big endian systems
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0149563190379220031=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0149563190379220031==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/TrEsxv82eU="; charset=UTF-8

--/TrEsxv82eU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1761?usp=3Demail )

Change subject: test_tls_crypt: Fix issue with temp=
 file name on big endian systems
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

test_tls_crypt: Fix issue with temp file name on big en=
dian systems

Encountered by Fedora s390x build instances=2E

Change-Id: Ib=
a577d662b389de539b81034735e437199cb495d
Signed-off-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761
Message-Id: <2=
0260702074746=2E3129-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37454=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvp=
n/test_tls_crypt=2Ec
1 file changed, 7 insertions(+), 2 deletions(-)




di=
ff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/o=
penvpn/test_tls_crypt=2Ec
index 82b1dc8=2E=2E1d8ac25 100644
--- a/tests/uni=
t_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_=
crypt=2Ec
@@ -722,8 +722,13 @@
 
     tls_options=2Etmp_dir =3D "/tmp";
 
-=
    /* Since we override rand_bytes the tmpfile name is non-random as well =
*/
-    const char *non_random_tmpfile =3D "/tmp/openvpn_tls_crypt_v2_metad=
ata__706050403020100706050403020100=2Etmp";
+    /* Since we override rand_=
bytes the tmpfile name is non-random as well=2E
+     * Build the expected =
name via the same code path as
+     * platform_create_temp_file() */
+    =
char non_random_tmpfile[128];
+    snprintf(non_random_tmpfile, sizeof(non_=
random_tmpfile),
+             "%s/" PACKAGE "_tls_crypt_v2_metadata__%08" =
PRIx64 "%08" PRIx64 "=2Etmp",
+             tls_options=2Etmp_dir, get_rand=
om(), get_random());
     unlink(non_random_tmpfile);
 
     expect_string(=
__wrap_buffer_write_file, filename, non_random_tmpfile);

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495=
d
Gerrit-Change-Number: 1761
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/TrEsxv82eU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1761?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">test_tls_crypt: Fix issue with temp file n=
ame on big endian systems<br><br>Encountered by Fedora s390x build instance=
s=2E<br><br>Change-Id: Iba577d662b389de539b81034735e437199cb495d<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1761<br>Message-Id: &lt;20260702074746=2E3129-=
1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg37454=2Ehtml<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvp=
n/test_tls_crypt=2Ec<br>1 file changed, 7 insertions(+), 2 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/te=
sts/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>index 82b1dc8=2E=
=2E1d8ac25 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_c=
rypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec<=
/span><br><span>@@ -722,8 +722,13 @@</span><br><span> </span><br><span>    =
 tls_options=2Etmp_dir =3D &quot;/tmp&quot;;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Since we override rand_byte=
s the tmpfile name is non-random as well */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const char *non_random_tmpfile =3D &quot;/tmp/ope=
nvpn_tls_crypt_v2_metadata__706050403020100706050403020100=2Etmp&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Since we overrid=
e rand_bytes the tmpfile name is non-random as well=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * Build the expected name via the s=
ame code path as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * platform_create_temp_file() */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char non_random_tmpfile[128];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    snprintf(non_random_tmpfile, sizeof(non_ra=
ndom_tmpfile),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        &quot;%s/&quot; PACKAGE &quot;_tls_crypt_v2_metadata__%08&quot; PRI=
x64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             tls_options=2Etmp_dir, get_random()=
, get_random());</span><br><span>     unlink(non_random_tmpfile);</span><br=
><span> </span><br><span>     expect_string(__wrap_buffer_write_file, filen=
ame, non_random_tmpfile);</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail">ch=
ange 1761</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iba577d662b389de539b81034735e437199cb495d </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1761 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--/TrEsxv82eU=--


--===============0149563190379220031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0149563190379220031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0149563190379220031==--


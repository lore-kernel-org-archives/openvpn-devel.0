Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFEC606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DsD8fLG7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b5CdELMA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hf/uS9rI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T5od/dUj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=brDM4X8ZtyAPkNN5zykwKTkFHTCT1xXjuJiZVB8VIAM=; b=DsD8fLG7kfqKKy7TvhFMbMYZ6r
	noTisc5YppnjFPEr4kMl/ddKezUVqw3SQ6XowykbRPtXSn+uorVIrNnhjCehXcFr6eYiaCzH2XngZ
	gJAfMIfQLbODi86zHJz/xJz29sp5+/HvKuchlfDG7lp1J9UzX0Sbcls/QvVZ33Dn/Ic0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVrKH-000000004QX-02Dx;
	Tue, 24 Nov 2026 14:16:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVrK1-000000004QC-48Em
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C1Qrwdz0M9syzbZtNMkwsz+2ASxb7U+YgOQllRwuZ3c=; b=b5CdELMAYT1ULWT7r3Evp48WJh
 hvptmJqLWMo8MSvFeZ0O/bGpZR0cZzW2Eobs1eInotA0ahERiZIgsUCu3jO77fa27HLKt8GULfFl0
 2ufRhnuB6UCf/SBvqxoE8OzB6T7/yZrXjJIMcWRK7EMccJbNz09VDHHTyIUr6EF66uy0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C1Qrwdz0M9syzbZtNMkwsz+2ASxb7U+YgOQllRwuZ3c=; b=hf/uS9rIeuZs7tKVYUFwBALApA
 6mwuqpCvSmg4k/NXiEHa7SBAowN2YAkYW5SLkogeQxFa+K2xFMNsxWH2RXVz/8GVAyiv5XXqmVGSp
 v1FVX3mQZ6fVBt3o6ZCfCJWx/W5ESOkng3JNUpbqcx8c0jSfKpiH7sflHhKoEjntLuMY=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVrK0-000000003WR-0mSe for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:16:37 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c50e26763a4so840562766b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795529789; x=1796134589; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C1Qrwdz0M9syzbZtNMkwsz+2ASxb7U+YgOQllRwuZ3c=;
 b=T5od/dUjKPa5g/GCopXcEz6WuxlkEyxq6kZTrWticXM+bA8tQ8KksLQLTF5jn9mhVT
 aiRCNgYXZAfmSIc+ybLTW2LfH14c1RyE5UEUTU0x5fL+GQ6rG6P36++1AoGYEU0BNam4
 yECVPBmTiBReMYRe7MaM1/dzQLs9zjDPLO36bZmUwDCCJYfVB6SgAFKSxXq8jIuzfGXk
 G0Ltf+WDwfVvqxBEzNgZpk33ekmfmvDHsqhN/VHct/dGU2eCw1Sbkg5xRSTurcm12IaN
 MTB97xIHlcxM+iWWICrNZ16BmoRKLNIW4WxEj+/eR7uCNhwV/iOS3MzffJ6dh84QFkGd
 1gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529789; x=1796134589;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C1Qrwdz0M9syzbZtNMkwsz+2ASxb7U+YgOQllRwuZ3c=;
 b=cz4qt/Jz1Pc6BiJ8uY+FQeCNDLKcs8K24EBPZHxbpTjsP7z4Me41H39FSkLXdlOrop
 zbPIfxuyga8ZSoSbWH6Y3O9deDPKuDKzvHhcDohtDoWQE5ppPu9ofuWC3z1IL7wN58ZQ
 ZLpLe9h+ijH4ICqAZYTV5p0iPqoN55Ke9Qm3BZoFqaoIPJhCqD94KGilCQmzNJDzCfvq
 UBhnnh97oSrvLqLkL9Dg0zAaTMKV5l1yKbaZEAxQI51MMzCticC5Poc4xSLHr6hhkjv3
 z9wlQoi/3S/7+JDIH4ea8n/1t91fTS8z5WUivbs0TzoBT0d46fpGJ+HRTIdDihOr9P9U
 4LWw==
X-Gm-Message-State: APuU4Z8sg2G6D5XoxGnhDTj3qmzivd2MLhBmq062gsPwIlAq/2VYae0m
 GS6sKWe2xvuD5ORKpn95knDuQg3AMWF5s4uOvNVqhlTeuZNp/MGl6P9u4UIz7z6PC6T4uyL0cNW
 VEn29spnr1nqcyN47Vtvr4pkLnEpf4nawKQqrfVVFd1dvFOQ4R9W4Lu9TZp0CFSs4fzxViKBcNx
 hJe02Azw==
X-Gm-Gg: AZFdTZdO8AIaLQVpZ1FdmRGj7/DUqVMd1A3FKbw4Fx0YHArRzD7qrqT8VpCdIh6pLxJ
 0CPCdl3SeH+1mf2Mo2t23CWdLxx9QEp8O43reHnDZYyQd+A4Nk2PTnt6pmxfHaxhzaDajlgwSCh
 qlHGyhjHD/Q+n19llq6GJKS5G8yfCd3cAcKQa2Fig37Q16U8S8ArE/mqvAbvM/eNLom1DU/+qL7
 1LnRrtXX8PkjjVw2HpgcPTkq/N8cDsysEcYKh6Nqg8hShDk9m58oBq4yTIISZSyRAnmapNwFh4i
 XUKA/j/II75Zlk2A5Zkp7D3IgDiDt/fNBGhuH9+U7AknAs0o6Zo5wDwv2n92fza7488Rm3BEIIq
 GwZMGtgec1ukUFQ5aHLpGXvSqb4e8s5ryuwWIBuixiyAm3ShtPSREqLxOqLy227ggrilJhURFs7
 VY+Mmh7ReMaKMdfjBw+yVopoj6aT63q9WYCCT6aOncXvPnd3Js2daPOR7PPqgE3q36hbA3uZOXR
 tV8ldiYBwxyYodlGhRLEFLOju2XIA/cMonABu3aSvt8wpp4rE9kvsNGYqgQaF2PDpyqDdtqPn+i
 Oa7habNAn9PQbmqoULKaL84D3577L8ACEJXQ2akEEyVS5f5V+OWrXnEk4VvThYlGwCZttK9hrn5
 Ow/grhgIZumt56QFRAWFrfUlRoJWcvS3xDC3kw4SRIkVLdi8h4m8RKqLcLwv8IXN0ZufIBy9u7G
 yTWFWKiOm2F03Pnxw=
X-Received: by 2002:a17:906:f59d:b0:c31:5bb8:4b3b with SMTP id
 a640c23a62f3a-c513a47d551mr1249858466b.2.1795529789161; 
 Tue, 24 Nov 2026 06:16:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae688f8sm538952866b.25.2026.11.24.06.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:16:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 14:16:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
X-Gerrit-Change-Number: 2337
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2337?usp=email>
X-Gerrit-Commit: 67bbc56f4580be77fd1e772d4c08fdd22d322172
References: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTI5Nzg2MDAwLkljYjkxM2Q2ZTg5MDYwN2M3OWE0NWEwZTYzZTlhMWJhNDQxNTFlOGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6c82e853d8ba3877c32ff6c479b84faea3adecca-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVrK0-000000003WR-0mSe
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: list: drop
 redundant check in hash_iterator_next()
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
Content-Type: multipart/mixed; boundary="===============2420392406079372875=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2420392406079372875==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TjOr2r7ivwU="; charset=UTF-8

--TjOr2r7ivwU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2337?usp=3Demail

to review the following change=2E
=


Change subject: list: drop redundant check in hash_iterator_next()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

list: drop redundan=
t check in hash_iterator_next()

hi->elem is set from b->list, which was ju=
st checked to be non-NULL=2E

Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44=
151e8e2
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/op=
envpn/list=2Ec
1 file changed, 3 insertions(+), 6 deletions(-)



  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2337/1

diff -=
-git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index dcd59d7=2E=2E505be=
30 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -294,12 =
+294,9 @@
             {
                 hash_iterator_lock(hi, b);
      =
           hi->elem =3D b->list;
-                if (hi->elem)
-          =
      {
-                    ret =3D hi->elem;
-                    hash_it=
erator_advance(hi);
-                    break;
-                }
+       =
         ret =3D hi->elem;
+                hash_iterator_advance(hi);
+   =
             break;
             }
         }
     }

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8=
e2
Gerrit-Change-Number: 2337
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--TjOr2r7ivwU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">list: drop redundant check in hash_iterator_next()<br><=
br>hi-&gt;elem is set from b-&gt;list, which was just checked to be non-NUL=
L=2E<br><br>Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openv=
pn/list=2Ec<br>1 file changed, 3 insertions(+), 6 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/37/2337/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=
=2Ec</span><br><span>index dcd59d7=2E=2E505be30 100644</span><br><span>--- =
a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br=
><span>@@ -294,12 +294,9 @@</span><br><span>             {</span><br><span>=
                 hash_iterator_lock(hi, b);</span><br><span>               =
  hi-&gt;elem =3D b-&gt;list;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                if (hi-&gt;elem)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    ret =3D hi-&gt;elem;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    hash_iterator_advance=
(hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   ret =3D hi-&gt;elem;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                hash_iterator_advance(hi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                break;</span><br><span>         =
    }</span><br><span>         }</span><br><span>     }</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2337?u=
sp=3Demail">change 2337</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2337?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2337 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--TjOr2r7ivwU=--


--===============2420392406079372875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2420392406079372875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2420392406079372875==--


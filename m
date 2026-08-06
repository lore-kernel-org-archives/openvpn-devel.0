Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E375FC56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=KrYtiSCEonXEfoplC81QXtA6+aTLNdZMcHOTFrUUNOs=; b=hxXZPSD1OVOO1Y
	LsoZz91MWigVlmKvWQtixfvdE0DKeUaV2Y0YM6TctmFHFhem0N+PyStajfmy1645SvldqlDLZs+VN
	o0fael5QTVIZi+IqH0CeMFYol4jEjnEJ2IEgfeCktbK522lrcutZbFfMD4prXd2bZ64R2diYm/aY3
	+Sk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrvyp-0001ps-NL;
	Thu, 06 Aug 2026 11:09:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrvyo-0001pk-64
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eeUIEDqy+npDZHxKPAEDcQzqsO0BemwV3PBYNTbM/eI=; b=SpBprT+vPLEYaZao/OF7IMYuU3
 9fTtxl+x1pV3SyQdDwsrUFVnkskQ4epBNnPytrQUPlkjIQsTtZmVk4/hH0KL8raoupruVG+PFKvjK
 D6X4otwZ2aCq3Z8mzZOZnCigAeHJqZkFOM6LUGMPdjJLFOEo278jmpM3gbgFBZSCKc30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eeUIEDqy+npDZHxKPAEDcQzqsO0BemwV3PBYNTbM/eI=; b=D
 X8NSQFRcQbvC+MfKpPSOAcczf+OSUtnORAejakTaWm1eC6MrsMKQcqcmjVJ/E8r5CgXXH2a+7PNt6
 JGa9no7GD968oGlWp6vlFgjuhjW1NpNfTDZuuNC232SLdHXDWVm1paqg44YFlHgexIb+igUkD3qpo
 E0UhfULb31xuPNfg=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrvyo-0005WZ-3X for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:09:42 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fdd674e17so1294338f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786014575; x=1786619375; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eeUIEDqy+npDZHxKPAEDcQzqsO0BemwV3PBYNTbM/eI=;
 b=Mbg+p/Xw51U+Nh8bZ+hIM/2dKum588H6iryZbfahY5qBtE1JVcVD1+CM4pBOCeBgv2
 42lr5KdcT0kUV8GYes7iHk9nd7/b40gf2fdEXDD/uyIigyDOuBJDTgzNDk8mEf+p5u+Y
 aOYESmlHFzSfne+EgjLiIEIHau7MmnkOJNk4oH4nRDY3isuv7rgjriTGpE6mX01BpmRU
 mn/cvOmKEINZHJcqrEVqsVaEN9Sjmx2ukyi+wn/FEH92wZlv4YssvFBdzFgCDnVJ0Ooc
 nwKbNJlS38b0sc2KSdHiYLeltIouus/m5QmGR+F3RIwtSE2guVoW7Tstx6lROx3Lc47W
 +vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014575; x=1786619375;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eeUIEDqy+npDZHxKPAEDcQzqsO0BemwV3PBYNTbM/eI=;
 b=S8m+78zNT2cFIQEF65DMaSRCzIv4kwJfHiDKqxt7bkdqjvAx3TjP83aFuYZZpoU1Wg
 dHY/K9/qCnVt5uzSIpPeNHPNn8p/Bi2jvF4bR8ndhFhk7wbRjuhZVte99W8I9KIOHioT
 9dwv7g4gOwrvJS2UsROlwXfBaW0AagkSpZzvdHClZ1oUFLnFVIx3G4B1Fb+GoT0excr8
 5I73ew+oV1wxR06nQc84J9JJ3bj+A9WwMytn/YbFb/a81gSzIz22OoDotAayH71qjUV2
 NoE+Ku4VR/u6Ql7lFXyEG1hAfT4g9jYGJmiAuwvHB/qiNDP/HLm/IDW7nI7VzoWEedBE
 ZJdQ==
X-Gm-Message-State: AOJu0YzH/utbxj9HOoVfgARSENy0SJJ2+7k8ZB/THaf0Hn7fUKUIc7d2
 V5rqTBPLoSj9gjFerYpRa7Syd7XcXPxrePpbcWTpe1XudMoUmWEAhSPHGt/YwKaVsMJJfzFSnLp
 E4lwtj7cOfGaQZ95OqKwlnvyJKDBgzdF9FBw2+/wF+SWJnOmBeScKUaYxTgJJl+YbEZQFSoGNBC
 hV78D5Hw==
X-Gm-Gg: AR+sD13nx3G7TWDekigzO8DI6+CqXBMOCFiwc/zuLQaX8W5zFv0yk8prkJuCV27NnSJ
 3ITLLY91HhNEPLJ+NYNI6VoC4eZP1I7m7NwMBVSjMdt5HN2QEfP8386NKFsQBYMgl+NoAvw5Mos
 wwcT19ty6Ai8f7tYT4z8Pv52PvI4Vqi4k+t2RXFcdRmbq7REK0R7cTaZqfIwResfwjn96CgTc+z
 7P6llyZreDKbrYq6CMEC589q1w8ebrYIXiEDZRRkBYFccvsgtYhcqZe0R4a/dqCIXxM3WgOLmR7
 6E38iBIBAu4BmP5fTNanjgl3cNpxlbWdu2nbJw7tIywtuCfBFg/hnBegatbwc8uUqLUTq6qMQm6
 PxID7ooLNNyc8ShuIrGqr3PJSpL01I2buR7ZCBzgV3y5aqw+p8ghc6RjKEQaTgs3Y6ljRtXFbHC
 +9LO3Kl6G1hJqSgFhXedFlzHQMWMPA92vPF85cAsN+mQ1IFOLk4hV8f78N6+be111202Wxjer78
 25AySjKCW92VeosDBXSPcunmuR9aE5ldx0tteKf29mjDotp6h2bYuJ2oY9SjaQeJFZSMFW7iqZ1
 x7+Zw1K9ggjyr0pOrKNbxwYSMb9TE7F3xbvQIF6Od/AIudTv6C0M/t8y4d4E9Q==
X-Received: by 2002:a5d:52c2:0:b0:47f:cb39:10c4 with SMTP id
 ffacd0b85a97d-47fec510060mr19186382f8f.12.1786014575127; 
 Thu, 06 Aug 2026 04:09:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79a72f6sm5338357f8f.2.2026.08.06.04.09.34
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:09:34 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:09:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
X-Gerrit-Change-Number: 1839
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1839?usp=email>
X-Gerrit-Commit: 0827214723a8cdd887b60250359a63b1ed8f147b
References: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2MDE0NTcxMDAwLkkxYTZhMGNhOGJlYmEzMjE0YjIxMDQ3NzU1MjQ2Y2VlYjMwMTQxYzJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e733114d2f2fe8306fbbe953836c08693438e78-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrvyo-0005WZ-3X
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Make test_misc
 compile with -Werror again.
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0580067848451638593=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0580067848451638593==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TauxBojcpzQ="; charset=UTF-8

--TauxBojcpzQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1839?usp=3Demail )


Change subject: Make test_misc comp=
ile with -Werror again=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Make test_misc compile with -Werror again=2E

Commit 5978a46e=
3 (master)/3402f9aa0 (release/2=2E7) removed the
local prototype/function g=
et_random in test_misc and use the
global prototype in crypto=2Eh=2E

This =
made get_random return uint64_t instead of uint32_t=2E
Adjust the calls in =
test_list accordingly=2E

On master the general hash rewrite/cleanup comple=
tely
removes the iv argument from hash_init and therefore
only 2=2E7 requir=
es this patch=2E

Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
---
=
M tests/unit_tests/openvpn/test_misc=2Ec
1 file changed, 2 insertions(+), 2=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/39/1839/1

diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/t=
ests/unit_tests/openvpn/test_misc=2Ec
index b9e2db0=2E=2Ea9c3845 100644
---=
 a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/te=
st_misc=2Ec
@@ -170,8 +170,8 @@
      */
 
     struct gc_arena gc =3D gc_n=
ew();
-    struct hash *hash =3D hash_init(10000, get_random(), word_hash_f=
unction, word_compare_function);
-    struct hash *nhash =3D hash_init(256,=
 get_random(), word_hash_function, word_compare_function);
+    struct hash=
 *hash =3D hash_init(10000, (uint32_t)get_random(), word_hash_function, wor=
d_compare_function);
+    struct hash *nhash =3D hash_init(256, (uint32_t)g=
et_random(), word_hash_function, word_compare_function);
 
     printf("has=
h_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, hash->mask);
 

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I1a6a0ca8beba32=
14b21047755246ceeb30141c2a
Gerrit-Change-Number: 1839
Gerrit-PatchSet: 1
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--TauxBojcpzQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Make test_misc compile with -Werror again=2E<br><br>Commit 5978a46=
e3 (master)/3402f9aa0 (release/2=2E7) removed the<br>local prototype/functi=
on get_random in test_misc and use the<br>global prototype in crypto=2Eh=2E=
<br><br>This made get_random return uint64_t instead of uint32_t=2E<br>Adju=
st the calls in test_list accordingly=2E<br><br>On master the general hash =
rewrite/cleanup completely<br>removes the iv argument from hash_init and th=
erefore<br>only 2=2E7 requires this patch=2E<br><br>Change-Id: I1a6a0ca8beb=
a3214b21047755246ceeb30141c2a<br>---<br>M tests/unit_tests/openvpn/test_mis=
c=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/3=
9/1839/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>index b9e2db0=2E=2Ea9c38=
45 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@=
 -170,8 +170,8 @@</span><br><span>      */</span><br><span> </span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct hash *hash =3D hash_init(10000, get_random(), =
word_hash_function, word_compare_function);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct hash *nhash =3D hash_init(256, get_random(=
), word_hash_function, word_compare_function);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, (uint=
32_t)get_random(), word_hash_function, word_compare_function);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash =3D hash_=
init(256, (uint32_t)get_random(), word_hash_function, word_compare_function=
);</span><br><span> </span><br><span>     printf(&quot;hash_init n_buckets=
=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br>=
<span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail">change 1839</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a6a=
0ca8beba3214b21047755246ceeb30141c2a </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1839 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body><=
/html>
--TauxBojcpzQ=--


--===============0580067848451638593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0580067848451638593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0580067848451638593==--


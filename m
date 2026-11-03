Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF3606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fueO2V71;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ktD1R2JX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DqxNWebl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Z7a9hcSf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FOy8RyRc7WM/lfKONFue+Vln7QlddA9h2XyMI+rDo/s=; b=fueO2V71+QUxAIVi0uF2PXZB6W
	9lOLxsWh7kSV0BnttK/QAe3R8WXEevLMYiR+EDnBDrEHrTKoMJU6tRbMfv4TdBUuUhWiSdie0QfE9
	WjN6qQEA1CxwllWq4ZQ5Uope4Tx0FR69b4qs3RxEXWABJhRjSn6h32lmlf05KoNyUcvs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOMDO-000000007Yt-43G9;
	Tue, 03 Nov 2026 21:38:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOMDN-000000007Ym-2t60
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJaSrcRszVlc56MJhrIGhgexQgMoqSqXYUky7EeJ6Ec=; b=ktD1R2JXuiIojQfUHpHRiIsGH8
 MYL3HROMLwIjRbRzHoxQCeCCKyvrSvxeLlpzbzMBv29bNFAnuohzOh9RgZLhy2w1giD7qvZYdjjTs
 fDTOt3eEqfJM7nwhM4rQ1cCA2gGQ6/SLXHXAw/vvFLna0reN06GF3kUG/JPg7VSs4/Vw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJaSrcRszVlc56MJhrIGhgexQgMoqSqXYUky7EeJ6Ec=; b=DqxNWeblpuPmSQIwUeQO5xyCMe
 OVdQIz0beagxH8xoTVsKPfCsISMfO41PrJGyg+egbZ1+Qt7vhI+hSXVCB2cbIt+WryExTqnBplMh3
 +NG7WFtpZ+8XNgfgqJ1XfYjr+P+IrflaEVAlXg+9DPu1DoBXuGeXhUZI2DvFlqf2e0HU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOMDK-000000000qY-3lgh for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:38:45 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so22237f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793741916; x=1794346716; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QJaSrcRszVlc56MJhrIGhgexQgMoqSqXYUky7EeJ6Ec=;
 b=Z7a9hcSfxeXSpBGejUTTJYdOX2FVtUmVD9Dx9iZATqPkIsdzT7Wka2DKjakGPvE/MD
 NVp/XVNoQcJMQaxGiSPy4GkPmd0H0kNoGUijdyasp8NC4e9UfAIw17TA+1RnyBTigmqu
 og/8kbzb1zF/mlYB3N85Zf/ha1fnnemkeH7wdTd3SR1ERHfvVgpXa1OWigdX5of90K8i
 rcQ5OJEEpf6qrSx3T6Op+XV3l5hw35Whu2dGFFbL1YeDVbzXm6s33zMSQmq+AtguIapE
 eDMArSHjtVjhG9I4dKeLL0KWvftkuOT0VOqQhZ5X9r6yeFLzhuf53ahJZuiPoGncuZlm
 8vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741916; x=1794346716;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QJaSrcRszVlc56MJhrIGhgexQgMoqSqXYUky7EeJ6Ec=;
 b=im84GS87bsf3TPZTDjfTuL6qcTpjtAjqtIxhSdoZthUf8QJFHW5/wvOHihaZGEl715
 ZOA29tVuozt7dznL50G6BcZEzBs5bblbq/92Cq+lQP97GVAeCYPcbesfCqBoNpjePL5A
 n2Xog4OcPqiSbIAPkg2pfIq9F+La6b2ffP1SsUKs6Z2Rn79xDsX3kmmum54BvbRq6yGe
 9aGSK1O9QYx8ebwHXclb9Qt9ZXBg0qhz0roscoZNCjs8og3CzTgJ3p7TXTG/CEpCIBx6
 qi+O1s8hz7nfbZq0z9fZJGAugz72cZPmXt0DHWjA5aGHi924v49gkw3bPgOGXXSicFuR
 BWLA==
X-Gm-Message-State: APuU4Z8ksqLIuKlAJRXFi+KhDmU4V1t6XvlpT7rWOqxkkulOMFw1etrQ
 4buurQcPCz+Z8fh3XIu1lWBPRQG1XtdTRVj/PpVitfRV/Fidlc3BtLoKqZaGOxoTu9slPky9/m2
 Ypgu+rvCHESyk1lVHevaXYObjf9cTx+ElVhu4QpZk0x9msAHFnPBW7qWYJUXI7BA7ONOm
X-Gm-Gg: AYBFou1B+slgdhBbNwV0Q7ONYGTL3NwIqSz+v1i+2G2WfFfZj4/4CFLoSdvNhR1HgDA
 iZQ9o/CgU4u6ADZd0cCtr18azIEb3s7QRA69bAS/MX/+D6Rk1p6SQfNTwZDihLqQy2RCOsP7Ro2
 wNH9IHnb93luOBP7HECxxhBq51vI3h8gwfW9EbOM/BgCF2FQjbl9BOmi2Oszn3EmuIkbOViceyZ
 CVLMYZkoGDYrPsAOY9TrJxNhmPTXU7M2rvGKmF5GoC8XuzVpi/ChZ7bEr1/W9o6Tuylp7xIupe8
 XrPyUkBtGaigJwzWiCmhpWFuboEoMDdytqtVfEgl14AmWVM/9xOvJPmRqX1P0iGdIw5eSrlLabL
 x2SIKgKPQ6vug74VaVUEapc52VRJ18jSH5/fOAjtONyu3V1+9ygtZPddpfVGplO7Gfkgy2AKFUH
 H0u9XoP+PBZpQZjMfKbesw1mW8hQxNZty+AKDq10FuTXZ4K3kb7FNcbM/p97bxF8wJSHPPYoOq/
 NNyAuEJt0529GfV+jcEX1kGMrARKsN9IXVF1oZA9F++g5oY387JXtoMNRyGtLN5jx2s8PazKlKH
 IoiphGO5NdKMb4MaUnytTR50ihIA3Eqbi/FFnWzB+0XcqxN3X/Fr1+G81Gti2ywYAPACYDSkVqi
 Cdf4QNkuKb0Rz/Yfz/cGradubpvPmEAvhRIG8Pt5TsfleoT3cT7f9SK8JXyRbTeR6oQfd8CB1+t
 4Cc3o3PcHTcn8z2w==
X-Received: by 2002:a05:6000:2610:b0:48e:3647:c35d with SMTP id
 ffacd0b85a97d-48e6e2fcdfcmr33478598f8f.21.1793741916156; 
 Tue, 03 Nov 2026 13:38:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d2bbsm169989f8f.33.2026.11.03.13.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:38:35 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 21:38:34 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Heiko Hund <heiko@openvpn.net>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd
X-Gerrit-Change-Number: 2110
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2110?usp=email>
X-Gerrit-Commit: 173dcf5609e54cbfbde0058e50e0c50fe4adae5c
In-Reply-To: <gerrit.1793733304000.Ib53e82554712d881b1e24f6f3a2f8fbb702951bd@gerrit.openvpn.net>
References: <gerrit.1793733304000.Ib53e82554712d881b1e24f6f3a2f8fbb702951bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzMzA0MDAwLkliNTNlODI1NTQ3MTJkODgxYjFlMjRmNmYzYTJmOGZiYjcwMjk1MWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2a759b74a99c9206fad6fa5545e2bc43b85915ad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOMDK-000000000qY-3lgh
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use registry default as format string
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8851592080161023945=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8851592080161023945==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5uX7jcQl+ec="; charset=UTF-8

--5uX7jcQl+ec=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2110?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Heiko Hund


Change subject: openvpnserv: don't use regi=
stry default as format string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnserv: don't use registry default as format string

=
GetRegString() passed default_value, which is built from the install
path, =
as the swprintf() format, so a '%' in the path was interpreted
as a convers=
ion=2E Print it with "%ls" and treat only a negative
return as failure=2E

=
Format string use introduced in b1263b06 ("Ensure strings read from
registr=
y are null-terminated")=2E

Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702=
951bd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Heik=
o Hund <heiko@openvpn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2110
Message-Id: <20261103200234=2E17639-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg40655=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpnserv/common=2Ec
1 file changed, 1 insertion(+), 1 deleti=
on(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
10/2110/2

diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=
=2Ec
index 7a23d41=2E=2E671ddde 100644
--- a/src/openvpnserv/common=2Ec
+++=
 b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 @@
     if (status =3D=3D ERRO=
R_FILE_NOT_FOUND && default_value)
     {
         size_t len =3D size / si=
zeof(data[0]);
-        if (swprintf(data, len, default_value))
+        if=
 (swprintf(data, len, L"%ls", default_value) >=3D 0)
         {
           =
  status =3D ERROR_SUCCESS;
         }

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd
Gerrit-=
Change-Number: 2110
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--5uX7jcQl+ec=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2110?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Heiko Hund</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">openv=
pnserv: don&#39;t use registry default as format string<br><br>GetRegString=
() passed default_value, which is built from the install<br>path, as the sw=
printf() format, so a &#39;%&#39; in the path was interpreted<br>as a conve=
rsion=2E Print it with &quot;%ls&quot; and treat only a negative<br>return =
as failure=2E<br><br>Format string use introduced in b1263b06 (&quot;Ensure=
 strings read from<br>registry are null-terminated&quot;)=2E<br><br>Change-=
Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvp=
n=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110<=
br>Message-Id: &lt;20261103200234=2E17639-1-gert@greenie=2Emuc=2Ede&gt;<br>=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg40655=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt;<br>---<br>M src/openvpnserv/common=2Ec<br>1 file changed, 1 insertio=
n(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/10/2110/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpnserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index 7a23=
d41=2E=2E671ddde 100644</span><br><span>--- a/src/openvpnserv/common=2Ec</s=
pan><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -38,7 +38=
,7 @@</span><br><span>     if (status =3D=3D ERROR_FILE_NOT_FOUND &amp;&amp=
; default_value)</span><br><span>     {</span><br><span>         size_t len=
 =3D size / sizeof(data[0]);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (swprintf(data, len, default_value))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (swprintf(data, len, L&quot;%=
ls&quot;, default_value) &gt;=3D 0)</span><br><span>         {</span><br><s=
pan>             status =3D ERROR_SUCCESS;</span><br><span>         }</span=
><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2110?usp=3Demail">change 2110</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2110?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb70=
2951bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2110 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--5uX7jcQl+ec=--


--===============8851592080161023945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8851592080161023945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8851592080161023945==--


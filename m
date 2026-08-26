Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6288BC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFOWlLUQFJov7hf3HH8/hw1pS8IDwH5inEWujhPEQmk=; b=P5gFGrgO7y+yn2jKHUeHF2fOwf
	CUrfuaU7B//401omgnlwtoS2C7w1rIgnU7kLrX9GqcTIVEFmJC4B0jrvluQ1Oz1szubKyS8ERLuqy
	6KAY5gc8yCiILVk4+811VcNAqZztrlvh24tkpJ5m5mRk3XySuG+qJl6U/KWhXbwGOEkM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7ZY-0007wE-6L;
	Wed, 26 Aug 2026 06:57:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz7ZS-0007vY-C5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Rjdv1ty4QTG4Nu1tgHVOHqK8vcrxH44tuEIw0irSAo8=; b=WAcuQadpUuBqrmGK1XDSYVmiXx
 NF1muqYc1FYyf/Qm6DPPhT2r+ZeOQG8dmLts1FoRcij2RfXj1/lIM3uajiTETG/y3NOtQqymTntZq
 Q0ZvIM730t09dyDAYnXj50ArZW6g5890CkyW7SC6GY9ljgPAtOdtmk8ODVarEJ+T9LBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Rjdv1ty4QTG4Nu1tgHVOHqK8vcrxH44tuEIw0irSAo8=; b=d
 LkeF7hVL0iLJgHL2wnkgkD+QEu3fPfgVrVY+BM11nO7gzcdms/xCAIGxWQGW4DIrmesXmpMhpco4g
 NvoQ3sfVAPas313QbQcX9JIp3qLgPEXiDQn+wsY9WUfXOt0o7JhDv05h4RmsuR5YVm6KperjJe3KO
 wyGd9iz4TX3xbxoQ=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz7Z0-0007gJ-AS for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:56:47 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso68273866b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787727400; x=1788332200; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rjdv1ty4QTG4Nu1tgHVOHqK8vcrxH44tuEIw0irSAo8=;
 b=W+iAT+GlVqRa+O8kyDgsBIlgoV+g+bM6h51ZAWDtrQgbno12USpuZ51KoVzAUZnMtH
 By+TdLc8lZzw309GzQGxIV+hIPkY9WQ1wQcuOjQetwHROsGxIuPu77lrWoLNlYYdJFvS
 S0ZJQn+TpSRtRxQrAYvKHMHH3D4QHbgNzFFgezHj3Rj14VfmaV6RZFGx/Gv6TRPGhw4+
 XYCubj8tLdaN/2riH4ISq5Xc7ICw2+hLyiQ46XBBV5ohz/Pa8x0zWPA0WJl0YSBf3M+8
 tgnk8JuXB2P0JbIxfsc+g4MCmjHCILRhTWLih8enHtrLDfTdXYhi2wJ8KjidDyxUkXuL
 mwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787727400; x=1788332200;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Rjdv1ty4QTG4Nu1tgHVOHqK8vcrxH44tuEIw0irSAo8=;
 b=gtNeHWDE8tQYNrGz7HCcO4TN26Szkkh4GBJxkUBWDC5iHnffA9ORngmgjAJee7ytOD
 z8uuyez+/KhGhrWO30UBcHcTxMONOqZbJrtD1f0VYCO3n0Yq+IMuhvlcS22TbLt7T9MW
 930L3NVJsVmP0kJncerRkCDcW57H1eOg0FoVqDxFHPYR10yUTpVP/vUMnYwS3xxZZLVa
 +bXdLqXOu/lfOqioiOKn82p6XwRBeAUS8juP94t/6lXHwEXPyO6QLO/zchvrgxCQynAq
 thysGhJkAsPVOOhGcv4PnvinjBovTWQqSo91v/WIIT2HquaOoU/ohqcEFxNJNPcMA1RH
 qHIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqntOEXA4Y7+byLSQknZQ/yc239jsBvFPBjiaU2t4PdUU9rtmUWcBceFXx2u2cB1Fy4+RehhQ3xe4TLwU9l@lists.sourceforge.net
X-Gm-Message-State: AFuF++kLbGiJbNo1l6qTZRy0ax24ZJ0h8yHmD+3jZ6bxMfT+zuCFFFXF
 ZD7ZYUy2HK87QJuk5o4VghYifasABzcq74ag4ORx2Jz7gjwR1KXl1qz/16P3N1OL9XlaaPu+nxO
 q8WilCr5W31aT7s9Os5OpzfwRMmxbk9j0qbWVbmnXc+tSP6nRtWG4Ohutr6062KFX0pzW
X-Gm-Gg: AR+sD13D5VX9cFGSu48G5pkMG8iuzozV3gW2UyA9L22oeNGXVjdBE/l0nX2ncroy4SR
 4upF8+aCb7hPanrhv3kBgPqpykKsS7P68lq7JJnLXdVZSHQQEKasX+VsTBeq7KpumB+EUNcxaxV
 sw9RS08F1SvPyxWTa4h3j9wAZSQxIoCVM5ddFtqED5cKNthls3yV37NACVsFTOiWbJHZYIbej+p
 G1Clw1v5QSK7guOWm+neT8eDVqZZSwdDO/anV4OC8emg5rLGOxHhqiacDwYR6PrLYOF2bNeMrdx
 gOSycgXFkMKwSSz7jSw1XaTktbPX7a8Zoi26Dfd/KkgrV+Q5GjGcoNYQO2tda2JwEn49vzWVVPJ
 W0JuvDn7+LO3+B6FHnXTykD/GYxOEDOgnxonPk/srNqj5qk9T9sdHkHw9bg1NHwCkwSTcKeeoqz
 6U9srgRRdLqoXVSd/20Fx4Mhuq+YKsLC1mx1ZYuRdQfe0DcxerLuOuOp+vzEX8ly5sqRX/UXyxG
 oOYfL4bhHD8aZTbp7DIMbM6AEXDTUbqKHoNuWM9DYy3P2sLswNmW7Y11EDj7GfA9z6eYHzvg1tV
 OgFYj3Ziprwzn7MOIjgVjN5SyEgdBu0i1oXLqrF+pJIHeAgW9uA=
X-Received: by 2002:a17:907:72c6:b0:c21:34a3:4df9 with SMTP id
 a640c23a62f3a-c250bb58ab3mr522279266b.3.1787727399573; 
 Tue, 25 Aug 2026 23:56:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b22ffsm298662066b.42.2026.08.25.23.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:56:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:56:38 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
X-Gerrit-Change-Number: 1861
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1861?usp=email>
X-Gerrit-Commit: 4f4b0771574e85787b15dd45a85a889ce66c16f9
In-Reply-To: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
References: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NDM4OTEzMDAwLkllYzM5MmE0NzEyM2Q2MThjMGRiYzNhNTI0MWMzOWRhNGFjODNkODgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <891775096d14c7484e13cea5e8ffd430b13ce84c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz7Z0-0007gJ-AS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: fix log
 lines format string
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5781384938710264121=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5781384938710264121==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EaZHLzBmoAw="; charset=UTF-8

--EaZHLzBmoAw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1861?usp=3Demail )

Change subject: openvpnserv: fix log lines format s=
tring
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn=
serv: fix log lines format string

The interface name is UTF-8 encoded=2E I=
n order to log it correctly,
it needs to be converted to UTF-16 first=2E

C=
hange-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
Signed-off-by: Heiko Hu=
nd <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861
Messag=
e-Id: <20260824180454=2E12181-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38650=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpns=
erv/interactive=2Ec
1 file changed, 9 insertions(+), 3 deletions(-)




dif=
f --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec=

index a9e9665=2E=2E36dfb8e 100644
--- a/src/openvpnserv/interactive=2Ec
++=
+ b/src/openvpnserv/interactive=2Ec
@@ -1224,19 +1224,25 @@
     err =3D In=
terfaceLuid(itf_name, &luid);
     if (err)
     {
-        MsgToEventLog(M=
_ERR, L"%S: failed to convert itf alias '%s'", __func__, itf_name);
+      =
  PWSTR wide_name =3D utf8to16(itf_name);
+        MsgToEventLog(M_ERR, L"%=
S: failed to convert itf alias '%s'", __func__, wide_name);
+        free(w=
ide_name);
         goto out;
     }
     err =3D ConvertInterfaceLuidToGui=
d(&luid, &guid);
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%S: F=
ailed to convert itf '%s' LUID", __func__, itf_name);
+        PWSTR wide_n=
ame =3D utf8to16(itf_name);
+        MsgToEventLog(M_ERR, L"%S: Failed to c=
onvert itf '%s' LUID", __func__, wide_name);
+        free(wide_name);
    =
     goto out;
     }
 
     if (StringFromIID(&guid, &iid_str) !=3D S_OK)
=
     {
-        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' IID",=
 __func__, itf_name);
+        PWSTR wide_name =3D utf8to16(itf_name);
+   =
     MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' IID", __func__, =
wide_name);
+        free(wide_name);
         err =3D ERROR_OUTOFMEMORY;
 =
        goto out;
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1861?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Iec392a47123d618c0dbc3a5241c39da4ac83d880
Gerrit-Change-Number: 1861
Ger=
rit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--EaZHLzBmoAw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1861?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: fix log lines format string<b=
r><br>The interface name is UTF-8 encoded=2E In order to log it correctly,<=
br>it needs to be converted to UTF-16 first=2E<br><br>Change-Id: Iec392a471=
23d618c0dbc3a5241c39da4ac83d880<br>Signed-off-by: Heiko Hund &lt;heiko@ist=
=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861<br>M=
essage-Id: &lt;20260824180454=2E12181-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg38650=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 9 inserti=
ons(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/intera=
ctive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index a9e9665=
=2E=2E36dfb8e 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec<=
/span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -1=
224,19 +1224,25 @@</span><br><span>     err =3D InterfaceLuid(itf_name, &am=
p;luid);</span><br><span>     if (err)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot=
;%S: failed to convert itf alias &#39;%s&#39;&quot;, __func__, itf_name);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PWSTR wide_na=
me =3D utf8to16(itf_name);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MsgToEventLog(M_ERR, L&quot;%S: failed to convert itf alias =
&#39;%s&#39;&quot;, __func__, wide_name);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        free(wide_name);</span><br><span>         got=
o out;</span><br><span>     }</span><br><span>     err =3D ConvertInterface=
LuidToGuid(&amp;luid, &amp;guid);</span><br><span>     if (err)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        Ms=
gToEventLog(M_ERR, L&quot;%S: Failed to convert itf &#39;%s&#39; LUID&quot;=
, __func__, itf_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        PWSTR wide_name =3D utf8to16(itf_name);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%S: Fail=
ed to convert itf &#39;%s&#39; LUID&quot;, __func__, wide_name);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        free(wide_name);</span=
><br><span>         goto out;</span><br><span>     }</span><br><span> </spa=
n><br><span>     if (StringFromIID(&amp;guid, &amp;iid_str) !=3D S_OK)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     MsgToEventLog(M_ERR, L&quot;%S: Failed to convert itf &#39;%s&#39; IID=
&quot;, __func__, itf_name);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        PWSTR wide_name =3D utf8to16(itf_name);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%S=
: Failed to convert itf &#39;%s&#39; IID&quot;, __func__, wide_name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(wide_name);<=
/span><br><span>         err =3D ERROR_OUTOFMEMORY;</span><br><span>       =
  goto out;</span><br><span>     }</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3D=
email">change 1861</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1861?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1861 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12=
fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--EaZHLzBmoAw=--


--===============5781384938710264121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5781384938710264121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5781384938710264121==--


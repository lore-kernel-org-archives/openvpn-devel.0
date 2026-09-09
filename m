Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737EDC79FB6
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yeb3Yby5Hoxa2nZLj21dP/PQSx01bcCoDCjngJou1PU=; b=fQHfbDhDCzXNPXHgwWlRuOrvIG
	cUZ3+LIKwqBPsyAKFof8YnCGMsj6vV03Q4oYEGpy3BcWvEVrEuCBaLygY8kPVlmIPznt0VOTNFOvi
	BxNJ0YzckmXodPTvOTg/UpKmHhURXXpNnmW+dGPu5EeyiOsspUFaXYfh5dimsQz9ZyLc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4IIu-0004HY-UH;
	Wed, 09 Sep 2026 13:25:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4IIu-0004HS-1M
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QRgzo7GK4NxhkKauxtdnG9K4xE1Mz5t1PnoXxzIMKO0=; b=li8IQ9RVYPkaPGNQTsHpofcI5Q
 2SXNwG2iPAGWOB8dQBDjbSf4zvcom3t1cYBRqKdUkxGVSGcbLHUa7vm6DZLYtWvsHyAVqo/2FZnbW
 HJ+LutxeYqKHGJceMHWNnZbUL2OnA7FXZ91p114+0fHM/pPpQzUGD/DTtuES1FNs0HGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QRgzo7GK4NxhkKauxtdnG9K4xE1Mz5t1PnoXxzIMKO0=; b=g
 heZIU2jXSBqYjBlIRQT7b+MABLx0ADx8gzcmZTdiLKQ6pOVhsljMibM28jyI1lFOHqgdv9WHdO6wX
 yOqpfOqAhanHZQbRVOQfiUzDcDAalvm1AQaclW6QeNp9Sa1K3eU5wB/WfAr3PUPNm6bjbSHUuk2ph
 sZy6u66EcbFzJrRg=;
Received: from mail-lf1-f43.google.com ([209.85.167.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4IIr-0003YQ-T6 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:31 +0000
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5b6036e9c70so4595493e87.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788960323; x=1789565123; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QRgzo7GK4NxhkKauxtdnG9K4xE1Mz5t1PnoXxzIMKO0=;
 b=M/XcBjyAuAPbgY07SLEUJChM6if1wy/i3Jih/n5J6Yh7bLlGegDNKHXlpddo9QMqP5
 iMuNsLO6DF8g9p5ddqdOFqktHJwl5WGDIDVky7gUNKcpC4CzDTvizaJhfiFPmeAGqeQ9
 3ncS9Wk4iucwiTZbF2nBN8lv7ant7w8lhJ4toxa6ha4uwmB5ZYSEDBw5DUXMDTJ6cmsb
 lkUe+d1NOT9uovsdLaozh7nY9njDy7FZrK4iiKldfrKAT/C8rnAeTc0jS8OptWL6jcKc
 Vh/RleBr6kBMbjdJwiWxZtD+1cHmV0/1EDcLloPLGnxGdIcEQy6Bbxk4+014KCJWgHtc
 9ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788960323; x=1789565123;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QRgzo7GK4NxhkKauxtdnG9K4xE1Mz5t1PnoXxzIMKO0=;
 b=Hg/NP/Y7yYyfn3rzTvxDoLZyeO47MztYeCNw9QmTvLMYO5KRmFNtJPOQswPjxJ65I1
 seRZ3r+DkldvmRY8e191PHLqUGELVUNcEmXJMC1huIilGNg3AA0bt6rVMoe1e5VhLMmu
 6E2PFtITZzLbAd1i0j3F62fxOQlBbDBngLdn4fmM31JW+oxaRQg1rNi/eoXXUzF8w5YC
 PFq/mKs8M5rnfv2O6Kltyy8T7nNLhf0DHgN28y+pqnlDpD959949HbQTcfuxbQ74IHn7
 eOeEbyblP0cHsxLo3mKG/oxv7+Yn/8WkYvJIQtGf3gGl/Xz6oA1vQNNTizN4achH7J9y
 BQBw==
X-Gm-Message-State: AFuF++lqeJqC9q73w9m+J0eDzNnfrylTp+5GLw/gArAePOTo4CrMpo+j
 fBdaNewTFhVrXUPejVsMYG9x6tDGNha0GxUyAA+R42tYtWYo42Jel3uSSY7+gJlHF+8E3tJ0jCi
 dZZR97hH0o3GDpF39LJIwNO98/U108wsYh/fNA8+oHeEpqSI6q3NIwlPz4fF9DbmvVAiO
X-Gm-Gg: AYBFou27TId2entNwRDCrQBsWbO0MQkNmnFSlDlJRWbGw7wlpEjvH8onqdYK0hoEqxL
 0PJMJxb3Oi52g/0dUkeT8f2zZWWlSvToY2USHD2KkPmglVKhQPWdKcL9GqavIXmBXYJ2qM3U6N8
 iwssL1wG0jX5BsI85EO7gRK10A8k5JVdMFkGuU7S89dRZf0AaNaEja+Wcwds1uMivrCNkXe4846
 WxA1qmiBIl2mqDMLxMb2Bt1ihr+0s2X5iF5ETx0MSB7Y1mewvPZAO9wNP6DETKdtM73J8yI6Ffh
 g819vGRDEBHq5CTRUTf3Sbqo/6dRgUeYJjUvrxx5VJIGg6gD9ngU3MzQsaS04UIvIM8AYtm9u2z
 4Os/KyI6K1+l2mqUIx22CiD8GfJ/pa9tzBVE+/JihmM9OWNe7BhVvm4OnxlqfpZ97KXzfp3zauf
 GYdNRYFU/4OJhzSl7zgBtWod/cKkJ6Y1DIdqC9PaTS50YefILvs58yfPUtTONBgwUs83TwOnuFp
 prb7eUgxGVGb6v4M2vvaEqSOVVUt32l3GF5T5CZlD2tno8RT+FdQYQAiLV4yb+46PHkTpTOBhWX
 pZ/HAFFYtimxGM4PO8vc6HAX2P+F8NDtfEdQ4HVFcS+8b36O7+V0hi2sMSRg8A==
X-Received: by 2002:a05:6512:3d8e:b0:5ae:b887:bb33 with SMTP id
 2adb3069b0e04-5b616f01db4mr6342383e87.1.1788960323012; 
 Wed, 09 Sep 2026 06:25:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a370549917sm46033041fa.11.2026.09.09.06.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:25:21 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 13:25:18 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1906
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1906?usp=email>
X-Gerrit-Commit: c1013297930bac77f5d3c4e1ec1ff184870d8804
In-Reply-To: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjA3MDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ba23acc442c47c69f2c943f17a61f0adb3423bd2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4IIr-0003YQ-T6
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: openvpnserv:
 don't allow '/' in config paths
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2021320595870381799=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2021320595870381799==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G6EO3R2o41A="; charset=UTF-8

--G6EO3R2o41A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos, razvanc=2E

=
Hello cron2, d12fk, plaisthos, razvanc, 

I'd like you to reexamine a chang=
e=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=
=3Demail

to look at the new patch set (#3)=2E


Change subject: openvpnser=
v: don't allow '/' in config paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

openvpnserv: don't allow '/' in config paths

Do not=
 allow forward slashes in user provided config paths=2E The PathCch*
functi=
ons do not treat them as path separators, leading to "/=2E=2E/" not
being c=
anonicalized=2E That, and the fact that Windows file APIs accept
forward sl=
ashes leads to possible directory traversal=2E

Discovered and reported by =
BreachX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: V=
ivek Parikh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tes=
ted-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Github: =
OpenVPN/openvpn-private-issues#162
Change-Id: I371aafba18d336bcfd3912e92c18=
301e39bf6087
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked=
-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1885
Message-Id: <20260831184657=2E3332-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38855=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
(cherry picked from commit eecebd88a38ffe1571d1a259da87f611=
b7b08e9c)
---
M src/openvpnserv/validate=2Ec
1 file changed, 7 insertions(+=
), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/06/1906/3

diff --git a/src/openvpnserv/validate=2Ec b/src/open=
vpnserv/validate=2Ec
index b0fb6b85=2E=2Ea59f9b1 100644
--- a/src/openvpnse=
rv/validate=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -72,8 +72,13 @@
     =
{
         return FALSE;
     }
-    /* convert fname to full path */
-    =
if (PathIsRelativeW(fname) )
+    /* do not accept forward slashes in paths=
, as PathCch* functions do not handle these */
+    if (wcschr(workdir, L'/=
') || wcschr(fname, L'/'))
+    {
+        return FALSE;
+    }
+    /* con=
vert fname to full canonical path */
+    if (PathIsRelativeW(fname))
     =
{
         openvpn_swprintf(tmp, _countof(tmp), L"%ls\\%ls", workdir, fname=
);
         config_file =3D tmp;

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1906?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=
=2E6
Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Gerrit-Cha=
nge-Number: 1906
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d=
12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerrit-Attention: razv=
anc <razvanc@mailbox=2Eorg>

--G6EO3R2o41A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos, razvanc=2E </p>
<p>MaxF <str=
ong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">openvpnserv: don&#39;t allow &#39;/&#39; in config paths<br><b=
r>Do not allow forward slashes in user provided config paths=2E The PathCch=
*<br>functions do not treat them as path separators, leading to &quot;/=2E=
=2E/&quot; not<br>being canonicalized=2E That, and the fact that Windows fi=
le APIs accept<br>forward slashes leads to possible directory traversal=2E<=
br><br>Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mi=
l v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by: Viv=
ek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Parikh &l=
t;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Github: OpenVPN/ope=
nvpn-private-issues#162<br>Change-Id: I371aafba18d336bcfd3912e92c18301e39bf=
6087<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>A=
cked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885<br>Message-Id: &lt;2026083118465=
7=2E3332-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38855=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>(cherry picked from c=
ommit eecebd88a38ffe1571d1a259da87f611b7b08e9c)<br>---<br>M src/openvpnserv=
/validate=2Ec<br>1 file changed, 7 insertions(+), 2 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/06/1906/3</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpnserv/validate=2Ec b/src/op=
envpnserv/validate=2Ec</span><br><span>index b0fb6b85=2E=2Ea59f9b1 100644</=
span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src=
/openvpnserv/validate=2Ec</span><br><span>@@ -72,8 +72,13 @@</span><br><spa=
n>     {</span><br><span>         return FALSE;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* convert fname to fu=
ll path */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (Pat=
hIsRelativeW(fname) )</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* do not accept forward slashes in paths, as PathCch* functions do n=
ot handle these */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (wcschr(workdir, L&#39;/&#39;) || wcschr(fname, L&#39;/&#39;))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* convert fname to full canonical path */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (PathIsRelativeW(f=
name))</span><br><span>     {</span><br><span>         openvpn_swprintf(tmp=
, _countof(tmp), L&quot;%ls\\%ls&quot;, workdir, fname);</span><br><span>  =
       config_file =3D tmp;</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail">=
change 1906</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> G=
errit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1906 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body=
></html>
--G6EO3R2o41A=--


--===============2021320595870381799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2021320595870381799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2021320595870381799==--


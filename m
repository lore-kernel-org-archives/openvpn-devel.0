Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC2606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PqBpmKKi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i7t/sL77;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MlflAn8j;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PWutUPse
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YM33HCjJN0FJJp8KSK+7IO6NKpO+Xop9+zWgXA3OIP0=; b=PqBpmKKi3XSbOlzgVRmvhKc+M3
	5v5EJE06V/bg2nVPrKT34gOi7qPM02oK1CEw5fj/d+Q5uonvxkTVYjMXj5q0X9n50GSTvMeH1l5pu
	UrQzv+Qo8+voKo1DMceoBo62rMC5l+IBUrzHKF7nNLmBDmQMHI0SZR6DoyTtngxsFBcg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaC1-000000005qQ-3EA4;
	Thu, 26 Nov 2026 14:11:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWaC0-000000005qH-3fDe
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L8yoQONuy8oF8nmXnYPyYiMnRIzP82bXIfSxIAUDsrs=; b=i7t/sL77rzdf+XcDl7DDEzfEtd
 f10ZhW1cvb9S/YNhcpRthuCYm53pvfqlC09vv7iiFMKsdvVZ2eXQgMZtT0qiVlXuHRaF+oSkPuHt4
 DS0CSyBOoV2XeE6YKyu5y/afZnUGHjqMDEoZ7/dm2HZUPNmCQsKKcj9UUiPj9n4kXmAY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L8yoQONuy8oF8nmXnYPyYiMnRIzP82bXIfSxIAUDsrs=; b=MlflAn8jk3tqe/EShnVwbYs+5l
 PwN5koL0+zExM5ffT0jAMAihJmWFktubJJn3EBDzKyvUhqoSkRAS21JoVFQcTWa74DHLIxdP2WHC0
 ReJVyVGvnU/Z1c21wi5RxRdBRo5JNJrBPFDylNNZrhXqYQD3iHzhz8q4cQPujSea8WSk=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWaBz-000000001Ba-04uW for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:11:20 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so41880475e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795702272; x=1796307072; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L8yoQONuy8oF8nmXnYPyYiMnRIzP82bXIfSxIAUDsrs=;
 b=PWutUPse5mkI1hU9GcUdlAEfamMPRRCo0OucyL8guHiD/9BtDB6kd4tOTW/L03jwDA
 iXIosK2MaqQ29UnZRiHZBFY9kfyqpwSEUi9s/j4e5V5zlcoslNk/48GxQhYdBzHmT+Yt
 GHkosIWz/N3pKc1qjDJHrTAK5Gr3Qv9jRtZwmccMZH5HnIavgTUsz1TrRuE+xAm9UP0G
 8FIp29DPcCIyV1bVEpdDfF54trWmEt7gh+pQpkc/3pIOfbI9hNTAxIW79iVPBtTkaAeq
 i3IH69KiQO0U+X8RPX1ucy90p4XWWAC78Lkigq4Ep4DkUAZ85fUjkFQI7k1+gABkKHUQ
 7EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702272; x=1796307072;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L8yoQONuy8oF8nmXnYPyYiMnRIzP82bXIfSxIAUDsrs=;
 b=2iXMrKgnrySZdcc5KKe4OEIPoBaFlgh1JdMiR/jWd43sXm46w9pW3GIySZqLNF08H5
 6aXUviRov55aCmbhc6eARexfr4N5JpRfO8HPPPXnP/K4vXZkJNSppaEdom9RLms5hjLM
 zvbzC7+HGDkJ3TtC6+eZKlqshx8V8d3W/Pe2vkXWFQGVADaKCy6F/eoJidvZGcca8iAp
 84TWyUkBdnqLDIStcUw9x9U6ls7W9vhBV51uYBZRnpKQS/LOag8lXTObIhvLGT06l1oj
 rV1JCnZV9QiQKrUT9J4wkq7gXDNQHJQUz/FGqyDXp5CdPShME+0DYBCTY3UxoFhitYsj
 Y9FA==
X-Gm-Message-State: APuU4Z/CS7khYIO99cSehvqyjXBE45iIxf59v3XRE9Rq4DJEDk3YppHZ
 BoVUOBNFBYUcsUB7qNYGw5Fu6o2aGdGSWUtW98czNIrszDt9If5YtD7Au6tpMD23qutCYA3pR9o
 w5SdJYXhkvv2HSq/svKvsYEVnLjl4ebfE5uJPEYRF2HyoV26TPNEdwJTG3a9WV6WvX7JH70mYoH
 04zkzJ5g==
X-Gm-Gg: AZFdTZfkTBrueiFly5CL9OZ084v5vudhEWfL0+IqJ6VDjojNC81iQssa7ppUkNw3tsn
 g3P7hA6J6eroL+LImuJt1VM+9JqkCDN53jNhTTGAaohvqRQL+A1oS1BmzNtFA3URn5oAwcEf9Kh
 4/YMgaPFDO2H0iBTKnsDeO44E6wH6fw50S9g/fRbmMafKIimSS+XdtVqxGGBhgp3VdtlN1RB89j
 HBF6crmxjChThgxk8/TYRtilbRaP5MuxbfrDgYIXylkZT8u0crqnNlY/E7cRLlf3mAP5LgmVqOU
 yoMMqh7tzAIGGIjfMubp4olSO88cd7Bo0Csc7BldBUndoKJLQqIQ07W7Y+h9EOU4tqmlttZw9Sx
 RmMbgoLPeaGGhfdgnwCeHPFqcZ2ziGInokBpRMs48bcrhGNa+tIHmTOA/iy2uUBBYYcE3Qa4aTA
 czdV10Q/EeyPQdVSsWkHLuwf90cS82UlsQAluPuRysSxLbGihVJYwQK9ftUGQYEstQdy6hqppq1
 HgKche4kAe1HrAjSgrfKU/IJy+CmCQkH4yZLckftslX0Ura6pOK1CuYfriMNQrjVybW4q0aBRcZ
 a4Vl5iDmrZxFTpjE2pYU1yhlXrQFI9spjqPI0xRme++PbgxOVJem5QLaPXli4p2/7O3Bsvec9bf
 0g3GMf4mdKh11VwakYIoqjk+WZ73lBiThojpdGL47Qb//ze6Ikih3vXfTPgZ2V/ZYOsSmL9n1Q4
 Q/YiFwXvUNC0G/kT0=
X-Received: by 2002:a05:600c:4f50:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4bb888063f3mr534021595e9.16.1795702272194; 
 Thu, 26 Nov 2026 06:11:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm598972605e9.1.2026.11.26.06.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:11:11 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 14:11:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c
X-Gerrit-Change-Number: 2233
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2233?usp=email>
X-Gerrit-Commit: f83a6ffe48bdbf773a66fb92fd86e64af3d24135
In-Reply-To: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
References: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLklhMzU5ODI0ZWVhODc4MDgwNWE1OWQxOTE0Njc0MGFmZTM2MzBmYTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b7bf913bdb92e86756c720a27d6fa69cf05ed7ee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWaBz-000000001Ba-04uW
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use stale data for NRPT exclude rules
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0092496171045553226=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0092496171045553226==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eJqBqsEeXgY="; charset=UTF-8

--eJqBqsEeXgY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


Change subject: openvpnserv: don't use stal=
e data for NRPT exclude rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnserv: don't use stale data for NRPT exclude rules

=
If the last interface GetNrptExcludeData() looked at was not usable, its
en=
try was left with the domains set, and SetNrptExcludeRules() created
a rule=
 from it=2E Clear the unused entry when done=2E

Change-Id: Ia359824eea8780=
805a59d19146740afe3630fa0c
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlic=
h=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233
Message-Id: <20261121094752=2E2=
8750-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg41755=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file =
changed, 6 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/33/2233/2

diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec
index d155fd6=2E=2Ef00e75e=
 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interac=
tive=2Ec
@@ -2494,13 +2494,13 @@
 {
     HKEY v4_itfs =3D INVALID_HANDLE_VA=
LUE;
     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;
+    size_t i =3D 0;
 
   =
  if (!GetInterfacesKey(AF_INET, &v4_itfs) || !GetInterfacesKey(AF_INET6, &=
v6_itfs))
     {
         goto out;
     }
 
-    size_t i =3D 0;
     DWOR=
D enum_index =3D 0;
     while (i < data_size)
     {
@@ -2600,6 +2600,11 @=
@
     }
 
 out:
+    /* Clear data left by an interface that was not usabl=
e */
+    if (i < data_size)
+    {
+        ZeroMemory(&data[i], sizeof(da=
ta[i]));
+    }
     RegCloseKey(v6_itfs);
     RegCloseKey(v4_itfs);
 }

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia359824eea8780=
805a59d19146740afe3630fa0c
Gerrit-Change-Number: 2233
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--eJqBqsEeXgY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">openv=
pnserv: don&#39;t use stale data for NRPT exclude rules<br><br>If the last =
interface GetNrptExcludeData() looked at was not usable, its<br>entry was l=
eft with the domains set, and SetNrptExcludeRules() created<br>a rule from =
it=2E Clear the unused entry when done=2E<br><br>Change-Id: Ia359824eea8780=
805a59d19146740afe3630fa0c<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeig=
entlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233<br>Message=
-Id: &lt;20261121094752=2E28750-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4175=
5=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 6 insertions(+)=
, 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/33/2233/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>ind=
ex d155fd6=2E=2Ef00e75e 100644</span><br><span>--- a/src/openvpnserv/intera=
ctive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><=
span>@@ -2494,13 +2494,13 @@</span><br><span> {</span><br><span>     HKEY v=
4_itfs =3D INVALID_HANDLE_VALUE;</span><br><span>     HKEY v6_itfs =3D INVA=
LID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t i =3D 0;</span><br><span> </span><br><span>     if (!GetInterfaces=
Key(AF_INET, &amp;v4_itfs) || !GetInterfacesKey(AF_INET6, &amp;v6_itfs))</s=
pan><br><span>     {</span><br><span>         goto out;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    size_t i =3D 0;</span><br><span>     DWORD enum_index =3D 0;</span><br>=
<span>     while (i &lt; data_size)</span><br><span>     {</span><br><span>=
@@ -2600,6 +2600,11 @@</span><br><span>     }</span><br><span> </span><br><=
span> out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Cl=
ear data left by an interface that was not usable */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (i &lt; data_size)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ZeroMemory(&amp;data[i], sizeof(data[i]))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan>     RegCloseKey(v6_itfs);</span><br><span>     RegCloseKey(v4_itfs);</=
span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail">change 2233</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia359824eea87=
80805a59d19146740afe3630fa0c </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2233 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Ee=
igentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--eJqBqsEeXgY=--


--===============0092496171045553226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0092496171045553226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0092496171045553226==--


Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B389AC61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=adMAfb43rNefWARtJ6V1wgudZdLUs2Iw64sk4WyUnVU=; b=XSHklnnVAwP5z63k33YSNEP/OV
	V/ncckMxOj+UwezsRgB8b1EI87CFS7SZDrug5lY23b7at5jzq1Ylr2ujslKnlC32m5f9RjGkzG1wb
	gJEIlWnM7vfW7qfuuSqfEvtk9h39X/AQj1rhHmLUZibqLtGRPMmssmHH9suuoM7OtbLA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1NVw-000621-3o;
	Tue, 01 Sep 2026 12:22:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1NVu-00061t-P3
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tF1sKi4UyvncUGJhvRVxiHmHDM7rXAVhzo9yoXe8khE=; b=PRTb/V4xBFg8btpRhk5G9EbWOm
 SZR2JN4vWi+bgMCsawmoA2fPNn3avHGSJOu4cPlNAx9NCwy3ykWOioqMB50qP29+5w+QErlt02e7F
 LCHagIAu8m8oQ0GPK0f2sBC6syBt0v5wiuEZXBRf6lYUGSeL4Pq/qJHs1T2OqLNmLq/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tF1sKi4UyvncUGJhvRVxiHmHDM7rXAVhzo9yoXe8khE=; b=d
 Laqx5bxKsHnTswQcmVjKBefvYyC4okO9Dc4g4OFRlvVI829dH0S05dyJl3oIFX4rKRFACX1/LC4oo
 mS7y7/A3ZH9KPtMf7+0q2kPiMawrxBFg2WvskUp2N9o3zC6bycBOTUNL7EDByoXq+9yC5RC5vvau3
 BL9/kfBulFUV8+e0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1NVr-0007Xx-Q8 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:22:54 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so2783288f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788265365; x=1788870165; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tF1sKi4UyvncUGJhvRVxiHmHDM7rXAVhzo9yoXe8khE=;
 b=YwkPeHjIgC0J8JCuS6utpFCCfE7GeeYeSD2+e0Y7doubnrAybbj3gWlCOsGK1bE32a
 IrFyUQpJA0ai2utwXuO8iALSNZ6NIlP9goFSx5kGgHlB7XBEzLPxagsRPpVhJogGVFKv
 9k4E0v3pEuZTCWL135mQw80o3G4hLCw76z4E+mXZ2yS4cR3uAxTMAecJwdvv6FYTJiXQ
 JoVVxgpppi3d8UhOopkGvO+F6EO4DeVQojXsKv0RlI0XSBo+E+wmJ31ORhjde8g3JDvG
 eXClb/HjUzq0/lX/xnjrR7MAXiosz8KCxJnD0/9PWBLbDytsSqMdmxAVdTYKt/NOTxLR
 T47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788265365; x=1788870165;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tF1sKi4UyvncUGJhvRVxiHmHDM7rXAVhzo9yoXe8khE=;
 b=NHtH14twfYSqmCKeQ18p/oY6ixYCFlqSOk5dzXWzIgtfSWS5mKn3jD1SSP2+OQtIM7
 WsJwneA7vrZduAquTmEWvcaJeJLGgXI9k2MAZUF+tR+nlxQcGJcbt+5DppyCnAv8n0AM
 7BYdgSHTnofQQ9hXfFNittl+DQyWzaWeG1LHHf/Vcah+uzmKbDS7DORhGAeg3NEbWGQX
 Wv7rQu5n3aRvamngUTCmyXKZCuNxr+8Zw7KUOyiviWKoRPtsRrGUFGkdfk0IMBVEOTvt
 oaJ7AkL7XSxX6x8lThDzrPXZfnBHZaUStHJe/PTh7F7Zzw72TEMDOcPd/lcxTYAzoRd4
 0jUA==
X-Gm-Message-State: AFuF++laKSB0aDNC5oUXX3hMWkkekJmxdHciBCBy4Ir23wa1W4CLvcyM
 ygxyN9o6SfgC3zRh0iJxKdKJtciNPiruIKzHIQ8fpcysVwEUp8AsjKnAotukEJlyr+NL7qiWOa3
 uK5chpM9XqGrWM8+/FybslOtVVMT9KkVTSAwYyOs+iQxc2bG+cpGDByiBS79CQxee5ESK
X-Gm-Gg: AR+sD107olUp9F7rbSwQhMdr1qITMg8y1c+N8ZE6vwJh/HEdXtv+xH7poc5Q+WW7Q9A
 mbr09lFoyi9Hd/Fvqsqcz9hejwzQUOf0MBvD45jPsvypqik+BTfmY6/ikQC7HnfIzI+gbWla0pJ
 EheK0p8Gii9rOIEc2L3j5ZQd3oPxclM/XAhLJ7T04Ft9nsoTVUM/sBJiWL+Me0cmhKfWo3zAbft
 4E0rNZnCQWk3iFeOYvAzrgnjFMGzj/z2bco6/UNtkGu1QrcUz0hImCsPjU1qfun7aOx3Jl4RskG
 1/dWhP06vHTS0gdMYjxnk5l4smD+oI8eNHDoUAqj/5SFNHmxkFrE+v7LcnhO0XvSwnR8Z4J48yB
 K7lkqulfRBq4gAC8AuY7X9vFN9Dl1tnaEzkNkXC8f/Do2DnZaU8VuJN5RHR4xvkJhA0HLxjJ1UL
 /krBBVLeDW+LbxE4mYflDfJJVCePjUl9eV8/bda1EhWRRXhtxcgrRchONGd6YvRV3mYQCgiQEYI
 PYB8VSkt+wcxr/FfSwSzlfSWXAeI54OvDld0Xw32BO/Vwc7hT4/xolj9BmkMoRGKVGt8u2LxDFj
 sVKsNSh06oSlnMeLlsRRdezV3Gl+0v2o/fyleI57H1d0NjjL50KC
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49cdc405494mr151526885e9.1.1788265364926; 
 Tue, 01 Sep 2026 05:22:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d791a7sm4706262f8f.31.2026.09.01.05.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 05:22:44 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 12:22:43 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1885
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1885?usp=email>
X-Gerrit-Commit: eecebd88a38ffe1571d1a259da87f611b7b08e9c
In-Reply-To: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b9191ae0142461340e303f740895999ecd46a9c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1NVr-0007Xx-Q8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 allow '/' in config paths
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1707091621852769501=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1707091621852769501==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k0YxOKOMVwE="; charset=UTF-8

--k0YxOKOMVwE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, razvanc, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail
=

to look at the new patch set (#2)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by razvanc


Change subject: openvpnserv: =
don't allow '/' in config paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

openvpnserv: don't allow '/' in config paths

Do not al=
low forward slashes in user provided config paths=2E The PathCch*
functions=
 do not treat them as path separators, leading to "/=2E=2E/" not
being cano=
nicalized=2E That, and the fact that Windows file APIs accept
forward slash=
es leads to possible directory traversal=2E

Discovered and reported by Bre=
achX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Vive=
k Parikh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested=
-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Github: Ope=
nVPN/openvpn-private-issues#162
Change-Id: I371aafba18d336bcfd3912e92c18301=
e39bf6087
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by=
: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1885
Message-Id: <20260831184657=2E3332-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg38855=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpnserv/validate=2Ec
1 file changed, 5 insertion=
s(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/85/1885/2

diff --git a/src/openvpnserv/validate=2Ec b/src/o=
penvpnserv/validate=2Ec
index 7c0a87b=2E=2Ee3ef8b6 100644
--- a/src/openvpn=
serv/validate=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -68,6 +68,11 @@
   =
  {
         return FALSE;
     }
+    /* do not accept forward slashes in =
paths, as PathCch* functions do not handle these */
+    if (wcschr(workdir=
, L'/') || wcschr(fname, L'/'))
+    {
+        return FALSE;
+    }
     /=
* convert fname to full canonical path */
     if (PathIsRelativeW(fname))
=
     {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I371aafba1=
8d336bcfd3912e92c18301e39bf6087
Gerrit-Change-Number: 1885
Gerrit-PatchSet:=
 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--k0YxOKOMVwE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnserv: don&#39;t allow &#39;/&#39; in config paths<b=
r><br>Do not allow forward slashes in user provided config paths=2E The Pat=
hCch*<br>functions do not treat them as path separators, leading to &quot;/=
=2E=2E/&quot; not<br>being canonicalized=2E That, and the fact that Windows=
 file APIs accept<br>forward slashes leads to possible directory traversal=
=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using Typhon A=
I Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by:=
 Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Parik=
h &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Github: OpenVPN=
/openvpn-private-issues#162<br>Change-Id: I371aafba18d336bcfd3912e92c18301e=
39bf6087<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<=
br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885<br>Message-Id: &lt;202608311=
84657=2E3332-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38855=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
nserv/validate=2Ec<br>1 file changed, 5 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/85/1885/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/validate=2Ec b/s=
rc/openvpnserv/validate=2Ec</span><br><span>index 7c0a87b=2E=2Ee3ef8b6 1006=
44</span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b=
/src/openvpnserv/validate=2Ec</span><br><span>@@ -68,6 +68,11 @@</span><br>=
<span>     {</span><br><span>         return FALSE;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* do not accept=
 forward slashes in paths, as PathCch* functions do not handle these */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (wcschr(workdir,=
 L&#39;/&#39;) || wcschr(fname, L&#39;/&#39;))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span>     /* convert fname to full canonica=
l path */</span><br><span>     if (PathIsRelativeW(fname))</span><br><span>=
     {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail">change 1885</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I371aafba18=
d336bcfd3912e92c18301e39bf6087 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1885 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--k0YxOKOMVwE=--


--===============1707091621852769501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1707091621852769501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1707091621852769501==--


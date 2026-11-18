Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BDC60A2627
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cLU85S66;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HDcwvVWE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SHAheNcn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Flwe0Qkg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r54mk071DG33e/fcoGGhychjGskRJZJ9OL5+Mi2UxLc=; b=cLU85S661Q1NxamILbHqzLSHQb
	OjvMkbferjnTV2Uf8S5FVXTYn/mMZ9OJMvMU7eLYb8NtbgEcX972OujRBp3YvV9rf2h548FQ5yJZN
	u8wJwkMjP+Scrm88zIPAGFBmzV51BxRh5xDi+2J2672WSA/+Ym3akDCqXE8mVugQixo8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiMm-000000006ai-09Cw;
	Wed, 18 Nov 2026 16:18:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTiMk-000000006ac-1tHR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gVxlslm30EZa5VplpIdipQSWnhmOnkrflQijNKZj8oM=; b=HDcwvVWEPKOHrCMXW8MY7/dZ+m
 /Q6oOdhH4WFFkSB8fwUIpQz95yDVvoyABtLgiFoXnALZQE4Vdu5txK6JkBBWLqNmC5EKG2Jim1qt6
 34pJGFG5DydgWlBGRkt8DcnI2odyXK4PRTvdNT8UdiEvrVCaRQ+oHc9w86cLoAI9lLBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gVxlslm30EZa5VplpIdipQSWnhmOnkrflQijNKZj8oM=; b=SHAheNcnBO9r90yRDkxCKn7UQa
 KDOWnlSKiLNFNNo7487IvDecsr+6zh16Go6YoN13jCZpXYePckKihByZd4P6tmd9biYaXqjEWfiPX
 YLX2xM1sP0WD+OiGvhF6hC1sV1cd4SaWzHOIbW382MUpcylyeIz5m9BnHhFcBntNtqQw=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTiMj-000000005fW-2wzA for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:18:34 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so12825045e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795018707; x=1795623507; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gVxlslm30EZa5VplpIdipQSWnhmOnkrflQijNKZj8oM=;
 b=Flwe0QkgvHNQA1oV8WAlPKqukclanCdhE0DyOvYTZLOFs0pWCCbq2dr/1x52A+T7Gz
 bt5lYuowNsr0ei1pPSI0WuLnP6yuBZshjWNLcHdRuIL1Y7xG4+fJy/t3lQljAZZgGwLZ
 C7Ji99H67FxzqFXrt0ZPf5KVGbDeq+mImCo4CwsULx/cJQnUoQ2TbFXiRMpK5FEykE/3
 s9SBmFHdj34E9uRrJ/6Glxt8SdJNgn4RjV32Isv7PTEfqk9wXZ5iroMazFPgSuCJbkXC
 edQJ4txFwm0tuqTJdG9B8P6FYpLc477SNuNhcOGzwVhpfSUxC9rsE9fp6aT1YPDofkYY
 fGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018707; x=1795623507;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gVxlslm30EZa5VplpIdipQSWnhmOnkrflQijNKZj8oM=;
 b=WVij46pSl5XmQQ4sZ47uasP3GcO0SwWKJ5tCZu39aoI6Kfol3+/+NH7dMDIvVZr46o
 Q0xboYqICV1HJkbjB0nH3hFnLme++qHZBGxeJrh1vr4Q72nyHVIzH/Mma/ZDBdG11qlf
 TZbLVZzKwFyFN3RiGHl9p/Ik0IyNTIca1qVPqf4j4JrOEz0Usr+oeJYXsJlV9BkogiYV
 VGfF4DQukkUHUkz0XtjgTTWL4eQ0DDy1aTp64XsnlDxp2TOyxOURsxb98nJGnWV4UnkD
 Qwogl5jjWBMNmm61/bqq8va6QB9wB1UYb0axxureV8YZzEhNiR33ObzvwlTZDut5uPos
 pwjg==
X-Forwarded-Encrypted: i=1;
 AL+hErHQMPnFKxTuEzJiJZZAS++FZJk4LyLt9n/gUvZthvmZq1nm214Zo12VD5Vi7XN3NkZvjixPqWw5DdwqlD+m@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+iV8EQsyrIfXSIR3XcRSEnFjfFPkqaCZdXNUw/KBIUMZYrKWoN
 uYnip7t0v3oC+t1AgyDq8JlsIR2eM7PeikwSfmHznrUw3ctYw87SeW+XC4t9tGmJvBHITB6LFuY
 SzrfxNIKZk+kizNuPTlndjmz5ZZiJkiujgOvijODfQ23pDdwStmlNzf/4bVAFVNbigfRs
X-Gm-Gg: AYBFou3/7Cro5amq9oc1C7elfpbpi+tDsoWiD70AcXtCEIrEcdo7hiUaHMgyn4Vs2gR
 8XfRENf8qDaxVFqNXyzf6qWciq6nfwiDObfcrisfVjNXu7Qh1c4EQIFl+zucwnMRmHdItBmFdg+
 cKD0FWnTrjg1DuSN/muq1lZQQQtW8nRdUcFF2tkodRebc9GwO1gzJp38IDhES2HgeUtOviz3s12
 gObJLqCChrl3CN++u7qSkPMDa/DdtTc4FkX6PTGsjZWlR9Al0yD4Li1cAtmDs+jT/BXB1IZ6uQ7
 aEpfNWL0fcdwE9KNp99AckCgvigQOuYm58h6YDUH6c8OAYgfMjEXEfonSWjsqNbZYisCBwpJZt3
 kgmqfruow38zW8k3C3+Ypz9KXAGN+yJHxfjnD8swzS/NDAjq2FVE5NnsCv4xDaNAJOpftBCu76Y
 nW1GML27aERKZ6Dt84qv11dW/BauQ8Xg581jBLBvFtKbzycSDzAc2ik3CQnZvXuz1k7j/akBzAu
 2Ls0L7Ai2SqHlMie+0rzz7LHlhzGX6aVnq5k+ctfDUrxIQKGWpXRUNmxyyXlcEvQtEHJ8XClkJz
 AijSdt8IAuRzkahd9R9AFclk5LcsSaOf6t3MyplLzEF3RZlZju/zhtTMGgdYVdIOFw6lchOZkrn
 FpzY8ei9JxILO2b0hAlWJ3Gzivk3TA8OjPrcDer/DP2sArgfYC4zbP/rF9dvK+chKP+g9xH7SJy
 4D6oAGEcGMFwQ2xp0=
X-Received: by 2002:a05:600c:a55:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb7da2bbdbmr54092995e9.25.1795018706891; 
 Wed, 18 Nov 2026 08:18:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e59f5d7sm36526455e9.4.2026.11.18.08.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:18:26 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 16:18:26 +0000
To: chesain <cvanteddu1@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e
X-Gerrit-Change-Number: 1338
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1338?usp=email>
X-Gerrit-Commit: 34b4d05091c2a1bd7ad203a0c12e963c01dedddf
In-Reply-To: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
References: <gerrit.1762026034000.Ifb4e9d79c167337fb780b53141d080abf55f3f5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYyMDI2MDM0MDAwLklmYjRlOWQ3OWMxNjczMzdmYjc4MGI1MzE0MWQwODBhYmY1NWYzZjVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6493bb5c452cd69c5ffd1a66554215113351b36b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTiMj-000000005fW-2wzA
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: CONTRIBUTING:
 add Gerrit option + links
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, cvanteddu1@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 yura.uddr@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 Yuriy Darnobyt <yura.uddr@gmail.com>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8443565684543549722=="
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8443565684543549722==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/HNViIENVAQ="; charset=UTF-8

--/HNViIENVAQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1338?usp=3Demail )

Change subject: CONTRIBUTING: add Gerrit op=
tion + links
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


CONTRIBUTING: add Gerrit option + links

- Add Gerrit as an alternative r=
eview path

- Add links: signup, web UI, best practices

- Final patches st=
ill go to openvpn-devel

Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f=
5e
Signed-off-by: chesain <cvanteddu1@gmail=2Ecom>
Acked-by: Yuriy Darnobyt=
 <yura=2Euddr@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1338
Refs: openvpn/openvpn#845
Link: https://github=2Ecom/OpenVPN/op=
envpn/issues/845
Message-Id: <20261118150332=2E13954-1-gert@greenie=2Emuc=
=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261118150332=2E1395=
4-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M CONTRIBUTING=2Erst
1 file changed, 7 insertions(+), 0 deletion=
s(-)




diff --git a/CONTRIBUTING=2Erst b/CONTRIBUTING=2Erst
index 67baa4e=
=2E=2Ee7afeafe 100644
--- a/CONTRIBUTING=2Erst
+++ b/CONTRIBUTING=2Erst
@@ =
-8,6 +8,13 @@
 
 - https://lists=2Esourceforge=2Enet/lists/listinfo/openvpn=
-devel
 
+Alternatively, you can use Gerrit for code review:
+
+- Web UI: h=
ttps://gerrit=2Eopenvpn=2Enet/
+- Best practices & account setup: https://c=
ommunity=2Eopenvpn=2Enet/Development/GerritBestPractices
+
+Note: final, ap=
proved patches are still sent to the mailing list=2E
+
 While we do not mer=
ge GitHub pull requests as-is, we do allow their use for code
 review purpo=
ses=2E After the patch has been ACKed (reviewed and accepted), it must
 be =
sent to the mailing list=2E This last step does not necessarily need to be =
done

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerr=
it-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ifb4e9d7=
9c167337fb780b53141d080abf55f3f5e
Gerrit-Change-Number: 1338
Gerrit-PatchSe=
t: 3
Gerrit-Owner: chesain <cvanteddu1@gmail=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Yuriy Darnobyt <yura=2Euddr@gmail=2E=
com>
Gerrit-Reviewer: chesain <cvanteddu1@gmail=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--/HNViIENVAQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1338?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">CONTRIBUTING: add Gerrit option + =
links<br><br>- Add Gerrit as an alternative review path<br><br>- Add links:=
 signup, web UI, best practices<br><br>- Final patches still go to openvpn-=
devel<br><br>Change-Id: Ifb4e9d79c167337fb780b53141d080abf55f3f5e<br>Signed=
-off-by: chesain &lt;cvanteddu1@gmail=2Ecom&gt;<br>Acked-by: Yuriy Darnobyt=
 &lt;yura=2Euddr@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1338<br>Refs: openvpn/openvpn#845<br>Link: https://github=
=2Ecom/OpenVPN/openvpn/issues/845<br>Message-Id: &lt;20261118150332=2E13954=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-=
devel/20261118150332=2E13954-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CONTRIBUTING=2Erst<b=
r>1 file changed, 7 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CONTRIBUTING=2Erst b/CONTRIBUTING=2Erst</span><br><span>index 67baa4e=
=2E=2Ee7afeafe 100644</span><br><span>--- a/CONTRIBUTING=2Erst</span><br><s=
pan>+++ b/CONTRIBUTING=2Erst</span><br><span>@@ -8,6 +8,13 @@</span><br><sp=
an> </span><br><span> - https://lists=2Esourceforge=2Enet/lists/listinfo/op=
envpn-devel</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+Alternatively, you can use Gerrit for code review:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+- Web UI: https://gerrit=2Eopenvpn=2Enet/</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+- Best practices &amp; account =
setup: https://community=2Eopenvpn=2Enet/Development/GerritBestPractices</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Note: final, approved patches are still s=
ent to the mailing list=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> While we do not merge GitHub pull requests as-is, =
we do allow their use for code</span><br><span> review purposes=2E After th=
e patch has been ACKed (reviewed and accepted), it must</span><br><span> be=
 sent to the mailing list=2E This last step does not necessarily need to be=
 done</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1338?usp=3Demail">change 1338</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1338?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb4e9d79c167337fb780b5=
3141d080abf55f3f5e </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1338 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: chesain &lt;cvanteddu1@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Yuriy Darnobyt &lt;yura=2Euddr@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: chesain &lt;cvant=
eddu1@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--/HNViIENVAQ=--


--===============8443565684543549722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8443565684543549722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8443565684543549722==--


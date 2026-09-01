Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2962C624D4
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4HHJD/vJxZNRnwitJLAzz7NAVhVatfPz3n0F7S1kyY=; b=VL9aoGpIVvxIafSHXLPTXwhCyP
	Zn7sZ+7SCH/p83dFJMAvvRn3l6kIV17JVER+/RkWsWfeztU4cEVjtBNAuG09g9TkrmKDdXAKGfSFb
	UztpfcJWyZmFHo4vlpx+1LtmDBgcedFl/xqtCe9BFh9hi8R7k2WHQEyjj019b9H7fak0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1NVv-0004Em-8B;
	Tue, 01 Sep 2026 12:22:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1NVt-0004EX-IC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WcYppRWJv/DO/BCFSmskVBH8E6dnAg7C3Sqx5+l181g=; b=AgtMOcfCMVi30Y4v+JeBvukUka
 EfAZS48CCVT7AxTIfJ1Q+YkP8/T72OBhIbaD72r7N1EcZ8Ya8OPTqWQlHYZwVszQC7G28scFNXc2X
 WcnG53IrDcUV27fTWYh+v0sl7gbaNfPkuUy0IoHKCNEMcrnyXuSyAu7nuvnbW/XjGF8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WcYppRWJv/DO/BCFSmskVBH8E6dnAg7C3Sqx5+l181g=; b=V
 r10j6gehzTrQ4Tat6W4gBBwc3VDCuAUSmCNiTT+PNtHYR7r4xZuKHPDboU7D9Pz0grPOiHMOGfxNq
 TaOYmPta1RUc8NqyszeGZlbsSgaIbemxPwWkbTOYGmnzArx80TPtaWJKYjx/Iaecc8AdOnDzZWclS
 6ktOp8lJWJJ7++og=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1NVs-0008P5-Ew for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:22:54 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so552357f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788265366; x=1788870166; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WcYppRWJv/DO/BCFSmskVBH8E6dnAg7C3Sqx5+l181g=;
 b=H44FnscadA60lUAJ7S+2y42hRElr5/uUM86hXbUKl1okzi8dUshCQKYUZhqGqAvuyT
 tq7+7airE1Xbypwgigq35h6AVnLijfgftEQ72rnHlK8z1BNOgXu+5qAxtsxF9UY8Lqrk
 9KtliYtBmoTaliHEB53er/cBAT5UJpEEIyNAKAmeNn2HsWmRpiZVDUSHyttedjz0U9rK
 o9h/Pl3/US560vXGHEitK8wsH23C1F+0z2XQxKulfBNZoBftOVeIUyjjCl299DqkggAk
 XU5w5PzixGViSvSjHEGe7NFnYC7OfPiCjD6w7Ibla1DxkoUvrtlYOO8Pkq7onJM2Pt6F
 PcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788265366; x=1788870166;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WcYppRWJv/DO/BCFSmskVBH8E6dnAg7C3Sqx5+l181g=;
 b=AlzzQBgrzaA81ZwJooi2NNXy/ax0jrKaCg12GL1Z5/epenLce+4WOgSgtEyrXWVpYH
 ZwXBVMoGjKDWilwGrowsCKmulhxH3I2HuvnifudRIKPy+lpUx/+c/vWnLT/5M4xMV/xV
 pLTsMROSu0oQzcsvcTwSdynB/JsAY2zOvBga3nCb2Fa3XRCiqFtbAgyYC55RvAtSpGC2
 BWVFN96J0rOKDeq6bkhs44wELhaiNpeMsbXCXKnsrul86suLk3Up+ScH3Cyzy7rVJHw9
 Fiqz6kQOeiqtjagxj81Nj6igV0M6bYM7sh8TuzrtPAUADHEazj6cno9St0sVRHP6EyEv
 HQRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6lxy6WyW3bBRO3Jpl6JkWV0mQwMi/Lz0bFupC5OKBvB2mfsR1q7j1RUdcRF8J2y8MCC2rKbHn10u5lpPJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++m5k76hLhQNUZsHN0CqMbVcP42RcMba0hf55JoYC01RoN0n/utb
 4ewtclPniunxKn+WevCxF4yleDL11uLBzBpB+V4VvQG1gnKw686PPWPaeCmjyfw6h7w8DtBnLp2
 wdP/5jTXu0xF8ev+3mt2ML06fhcVdQy5EmAjrpkBQqGloHj4kDvQtRr6GZv2z5ELXT+mR
X-Gm-Gg: AYBFou1myVPpiOdVAX6I8tsonhUi2IoKdP9JmyCZFXch8kQyoou3k8b3G0s8nosuoLG
 50xIqLrQtU1oLbfqVorf4bbagcW8DKVieIWU7AK8bfzZhYX9N7Vd6pI6C3iwDyetKfDfpkboT1V
 CJk9sgX4gATusoW/7RsDRWaqF90Evxr1aEd+Hu7zee6gcdmWihduXPlJI53ULuzA1Al+Xwtzheb
 tezbdHamGBNZ1xRDP3K+Yq2LDWYAQsce1UQ7EklUEiZ7kOaQu9Fg++vE1XtKGzV+k9xiTqX7fi1
 ZqFHgbzHCPqEHmTPicX8O5IK7XI9dWqWBA1GvviB38g1sWEWx+MgIF3i0CmCsDoPw1mR0/Qq8w0
 984bNEhMK6C/DjUvEwSWu1BA9oKWEh47/k6eYkykCpj4UHZjNQhGgOA4zCukGhsKStEGKhQtBI5
 YiT7plzmB3ndYaoWcZCBh9KD4lp3NlY4vpMJ/zqDiAo6vaWoWinelioODnqBnXKx0+Lb4rYSpNA
 VVmr+7h/AndGncMrpvh0SNo8yHf8VbiUuvFHrHSbLkGl+zY1VEVBCBqOmg/r8uuUQ3mKwX3NJdS
 JF4CLbVKihY+n41625sggiVUsxILOdO8xKejSj1mg9yFOOGmvrk=
X-Received: by 2002:a05:6000:654:b0:482:f270:6a59 with SMTP id
 ffacd0b85a97d-48441fc0e68mr8439869f8f.1.1788265365817; 
 Tue, 01 Sep 2026 05:22:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d7c1c0sm4692207f8f.32.2026.09.01.05.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 05:22:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 12:22:45 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1885
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1885?usp=email>
X-Gerrit-Commit: eecebd88a38ffe1571d1a259da87f611b7b08e9c
In-Reply-To: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b9191ae0142461340e303f740895999ecd46a9c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1NVs-0008P5-Ew
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5218058684850041460=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5218058684850041460==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9KatSWH+qqI="; charset=UTF-8

--9KatSWH+qqI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1885?usp=3Demail )

Change subject: openvpnserv: don't allow '/' in con=
fig paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: don't allow '/' in config paths

Do not allow forward slashes i=
n user provided config paths=2E The PathCch*
functions do not treat them as=
 path separators, leading to "/=2E=2E/" not
being canonicalized=2E That, an=
d the fact that Windows file APIs accept
forward slashes leads to possible =
directory traversal=2E

Discovered and reported by BreachX Zero Day Labs, u=
sing Typhon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

Reported=
-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Parikh <vi=
vek=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Github: OpenVPN/openvpn-private-=
issues#162
Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Signed-off-=
by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1885
Message-Id: <20260831184657=2E3332-1-gert@greenie=2Emuc=2Ede>
URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
8855=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpnserv/validate=2Ec
1 file changed, 5 insertions(+), 0 deletions(-)

=



diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec=

index 7c0a87b=2E=2Ee3ef8b6 100644
--- a/src/openvpnserv/validate=2Ec
+++ b=
/src/openvpnserv/validate=2Ec
@@ -68,6 +68,11 @@
     {
         return FAL=
SE;
     }
+    /* do not accept forward slashes in paths, as PathCch* func=
tions do not handle these */
+    if (wcschr(workdir, L'/') || wcschr(fname=
, L'/'))
+    {
+        return FALSE;
+    }
     /* convert fname to full=
 canonical path */
     if (PathIsRelativeW(fname))
     {

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6=
087
Gerrit-Change-Number: 1885
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert=
@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: d12fk <heiko@=
openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--9KatSWH+qqI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1885?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: don&#39;t allow &#39;/&#39; i=
n config paths<br><br>Do not allow forward slashes in user provided config =
paths=2E The PathCch*<br>functions do not treat them as path separators, le=
ading to &quot;/=2E=2E/&quot; not<br>being canonicalized=2E That, and the f=
act that Windows file APIs accept<br>forward slashes leads to possible dire=
ctory traversal=2E<br><br>Discovered and reported by BreachX Zero Day Labs,=
 using Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><=
br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-=
by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>=
Github: OpenVPN/openvpn-private-issues#162<br>Change-Id: I371aafba18d336bcf=
d3912e92c18301e39bf6087<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigent=
lich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885<br>Message-Id=
: &lt;20260831184657=2E3332-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38855=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpnserv/validate=2Ec<br>1 file changed, 5 insertions(+), 0 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpnserv/validate=2Ec b/src/=
openvpnserv/validate=2Ec</span><br><span>index 7c0a87b=2E=2Ee3ef8b6 100644<=
/span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/sr=
c/openvpnserv/validate=2Ec</span><br><span>@@ -68,6 +68,11 @@</span><br><sp=
an>     {</span><br><span>         return FALSE;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* do not accept fo=
rward slashes in paths, as PathCch* functions do not handle these */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (wcschr(workdir, L&=
#39;/&#39;) || wcschr(fname, L&#39;/&#39;))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span>     /* convert fname to full canonical p=
ath */</span><br><span>     if (PathIsRelativeW(fname))</span><br><span>   =
  {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail">change 1885</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: I371aafba18d336bcfd=
3912e92c18301e39bf6087 </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1885 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--9KatSWH+qqI=--


--===============5218058684850041460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5218058684850041460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5218058684850041460==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A6606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T6S3po4D;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lJD+uh8i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K7oDqXDh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AFqvHQUh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wGJb78/w/iZNU8B/yoUUzs0ydY2JyxF4LYiRVWwuJrQ=; b=T6S3po4DIoQTr5ZP6ouuexNy8m
	sJRHlNMJfY2e+o2+xA8yrE8L34ol2Fb/iPToKM96rs4SGXhy/uHlNjUp8v8itdJy1d8MFFkjLy8us
	CTNKe5hKeIbIZ+fo/3xyYh6yfBlnK9eNJLx6vbUgwxD3IvlJvgXU5LLRwHTyhtT9EICs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSanz-00000000273-3gaO;
	Sun, 15 Nov 2026 14:02:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSany-0000000026t-3vuW
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GRuK91E2FuyVE5nJcZSONxribq+npImOzOW7DJariAs=; b=lJD+uh8ig3m5mkE5nluyr0Sv0m
 /HrsWdHG5rE3ZY3yzxSpa18svCk1r6AQrEJT8ZAR/r4lPEVeOvylXNuR6yalfI5/PpBjj5bB2q4Ri
 mTY/ciHZI/6yPGfARdzh3sbdHincdYAy9abm+sr2Z/eevX4P5Xynk83vmdHcoH1ESN/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GRuK91E2FuyVE5nJcZSONxribq+npImOzOW7DJariAs=; b=K7oDqXDhT55oslengizD/t4Z+r
 P3R6sgZ1fJlKRx/AQjvWqAY6jOsQoZp8DxNXsSXa91Er25e1KDH/PUmkoUParmNIZip4LT+93VQ3i
 ImB6/+0GD/MF0MDuxgPXN84ws7sBk3TsZCqYh4Ag8e9AoiDju6TWZ9eawz98BSjAD3gQ=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSanx-000000001aW-2VzE for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:02:02 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so666275e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794751315; x=1795356115; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GRuK91E2FuyVE5nJcZSONxribq+npImOzOW7DJariAs=;
 b=AFqvHQUhTff4pJI5aSDrmymKK/HncoY58RZdL6/99RRYZiEPfZOflLtAZtckoX3Ucg
 MBURaPYrSbBeT3WcCRcSkqEZlg+UhtT0mEoVwroIrU5+FzWAOXH1pjZnAJZc+37ZGYPe
 1FFVC7ROw9KL+e/LOLy273dx1OCy4u9j1dGXOByqXlmx1yALPrNeZrmPw0sux3wkLkKh
 C2112vzzYHnwPrHPZehdRdB2Ol5L5hLNcnPmH787xH2SYypTraBbCNZYAqWUzcpmzTNL
 gEAi1Z9QKYmEHG03xQPjLJFeLjpayrgJWW22UGDMn9bzBn3X7Ca/LyQq+gpVHmyTXv0c
 BeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794751315; x=1795356115;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GRuK91E2FuyVE5nJcZSONxribq+npImOzOW7DJariAs=;
 b=FJMzYq6I7SQABFwjDXpHB770ux9bmA1agKXPVoBCybZlz5fQm0zGmb7pTPOiroz2mW
 nynffLrZPr+d5u4vTVSy0gJ7SCbO/4ZUQB0ibZ4sP/7YqIer4b+SL0pCcn4FDL9pbD4e
 9ahiQORgEplMgNRtJf8FenzJRIkQ4ckbPsR5KOaWMW0cbiTDYnDWG3WsFvkyjl2PF+PQ
 HU1CpsGW6kd9t8xVePQQM3TRG+8RFDM4bQZJ3tGAqTlku1PwdSVRncvfroNuDp3mJoer
 BSsR4jxkANR3/eIH/J4XIQQdN87WC6adFn/HObJxbag7jkKoDZFxSJolBGdrvLMNGBiH
 U5Bg==
X-Gm-Message-State: APuU4Z9aEtoGVdET7+cgz59aG/EezkQLg/wzS8K+nT9sMwsbTT5sKwAg
 +R9krmn+jK4zbAdLN/AEKDXKy4Nkcr7ir0i+kHlPbJb2rRWHPNoQgcIm/W8TVlzu2sFJBLZh8Pz
 vj9OwcDHrwE1xBrmuvdsGsFYlZBSG2ZMDug4rmCkN6gPs7aLhBbTaUhqwBgfMLaN0irfxu6HqTY
 0SAsUebg==
X-Gm-Gg: AYBFou06p1KZkq+kzz1kt7i1RMYDBzAaTdoZyMluy6cyPcI/h3um6O+GgMt0iUiistY
 6Y+kvlONpRpQLw1I47V5DVGElyAD54YRI+Wm/4mRG0YqS9Uw3b9RXYhpNCoEVIwTMh0drt4BH8C
 RzTLLmubRyU1HA413Rc71fSjaQT1bZ6/U5wLDMtyBGW1E8X3sZJMpapsJwaTD9cGnCLxJsyJDJd
 aEgZW7wIwIFFxRHB6yRvaKqFw/k1p/MxdlZ4B0FU6L8RcS3Z9VTo9F5PkTRYQi4pZq0oKK7FpHM
 Mf3kQfWcZgBG7/Cee0wTk3S/9ksh5t8Ue4P2xw9MtDSIYAHLRnfCfQHx1hGBViYiIm65dY0PPtZ
 X2DqMTyzvaWDxvM7iLXH6sag1WL1zhfFwQNuNUHBr1Fhb4Oa47NqFPgjQTa6N7CDkMp2sHuLoi5
 s/JPsfFljak9aUTH9b5FNYx/6svBexFxa1rqwd89xNiedGzDbA5rBgut1PYMtajoc+0zzUiQ/t5
 tV3Tl7+shbuQuhIgqtqM52/OpvZohAw87geS0X297ZFPcBMDkKnADWt7CzV3Q03eqFJheZ5rVb/
 r97aiCsu+rojZTO+viQfF6u+fetLvJ+hMPnNzOap7lX4qnc+s9EWlabZVgDpvLNgcqDUTRs+nkH
 yzFw710vjDZjuac47gve2gqRBJtZS1zb/+t8YbQifM+0DXyIE5ETZ14ygmcpbx3lRkUoUyUilM4
 beQMHUikeThcENouIs
X-Received: by 2002:a05:600c:3152:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb55aac0bfmr174300955e9.34.1794751314713; 
 Sun, 15 Nov 2026 06:01:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2adf53sm317499465e9.15.2026.11.15.06.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 06:01:54 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 14:01:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8
X-Gerrit-Change-Number: 2171
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2171?usp=email>
X-Gerrit-Commit: 85b913866cc27c05a2b7565b36ccbad11333918a
In-Reply-To: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
References: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg0NzczMDAwLkkxMjk1ZDkxMWM5OTNhMDIzOTc1NjVlMjZjZWNlMGYwODYxYTJlNWY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7292d405ab65c145b623348f814fbd7b1949d66f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSanx-000000001aW-2VzE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: free
 actual_name when replacing the Android tuntap
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3116870695567543049=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3116870695567543049==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A/hbWa/SI1c="; charset=UTF-8

--A/hbWa/SI1c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2171?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Antonio Quartulli


Change subject: init: free actual_na=
me when replacing the Android tuntap
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

init: free actual_name when replacing the Android=
 tuntap

With --persist-tun, do_open_tun() frees the old tuntap struct but
=
not its actual_name, leaking it on every reconnect=2E

Change-Id: I1295d911=
c993a02397565e26cece0f0861a2e5f8
Signed-off-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171
Message-Id: <2026111319=
2654=2E11321-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg41281=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file cha=
nged, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/71/2171/2

diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec
index cb89627=2E=2Ee1052c5 100644
--- a/src/openvpn=
/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -1816,6 +1816,7 @@
         if (c->=
c1=2Etuntap)
         {
             oldtunfd =3D c->c1=2Etuntap->fd;
+    =
        free(c->c1=2Etuntap->actual_name);
             free(c->c1=2Etuntap=
);
             c->c1=2Etuntap =3D NULL;
             c->c1=2Etuntap_owned =
=3D false;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
171?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I129=
5d911c993a02397565e26cece0f0861a2e5f8
Gerrit-Change-Number: 2171
Gerrit-Pat=
chSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--A/hbWa/SI1c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2171?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Antonio Quartulli</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">init: free actual_name when replacing the Android tuntap<br><br>With --=
persist-tun, do_open_tun() frees the old tuntap struct but<br>not its actua=
l_name, leaking it on every reconnect=2E<br><br>Change-Id: I1295d911c993a02=
397565e26cece0f0861a2e5f8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171<br>Messag=
e-Id: &lt;20261113192654=2E11321-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg412=
81=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/init=2Ec<br>1 file changed, 1 insertion(+), 0 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/71/2171/2</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec</span><br><span>index cb89627=2E=2Ee1052c5 100644</s=
pan><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/=
init=2Ec</span><br><span>@@ -1816,6 +1816,7 @@</span><br><span>         if =
(c-&gt;c1=2Etuntap)</span><br><span>         {</span><br><span>            =
 oldtunfd =3D c-&gt;c1=2Etuntap-&gt;fd;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            free(c-&gt;c1=2Etuntap-&gt;actual_name);</s=
pan><br><span>             free(c-&gt;c1=2Etuntap);</span><br><span>       =
      c-&gt;c1=2Etuntap =3D NULL;</span><br><span>             c-&gt;c1=2Et=
untap_owned =3D false;</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?usp=3Demail">change 2171</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1295d911=
c993a02397565e26cece0f0861a2e5f8 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2171 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--A/hbWa/SI1c=--


--===============3116870695567543049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3116870695567543049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3116870695567543049==--


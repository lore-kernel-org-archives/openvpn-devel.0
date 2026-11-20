Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B71606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MnEwE93Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NaRtUknz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T773eDeY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eC9gXj/U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fkx1EqNxlDPk6A+XRFFeiwZSSbDzhM/w/1Zch9saTRs=; b=MnEwE93Q2amF1a6KHAMUg8ciYS
	Tw7cBj3arf+orVy9mOJAHmTfG+p/91vnRtsAqYhKGvWcNtQkF58tSBK/Zcp0KeCCRvyetbpyI73LO
	wFCT1+6OFfj+0QVJW+10HgsR+Vcqt8fDOkCw9baxOWLZP+v37QcJBtNiuAzDvtDAPmec=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJ2V-000000001Nq-28jT;
	Fri, 20 Nov 2026 07:28:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJ2U-000000001Nk-1AKI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YitxeEqJjeuuQP2ExFX04K5fMURIXK9L20+ha+ziMJA=; b=NaRtUknzo3GsrTYpQ8+VHXgHoL
 b8/1SV0kdKbYZ6zthlBBMkvhOQ1B4CAG21ypp1PeSUfYlcHkHGrhCXjvYcumXOfE5yBdqrTy+ZwgX
 e+6Y0W3vkKncOBLwUbZLJidabNOx+kN2gIwfjnrBcz2rRTBTlWGFZKekup4VxveP4Vgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YitxeEqJjeuuQP2ExFX04K5fMURIXK9L20+ha+ziMJA=; b=T773eDeYwhxLgZhRTWdYlHOmz1
 /Tjlpl5PMpcT5YGJne8wWEXxHFiSJYMAk3rP3XpsHI+f66C5Kn0LjLkmniPzGG9iuUilf6fc31sGU
 yVYzJhqmaq7zO1Cpaqo9rG9It7WVRJ1UcpuqIP3/meupisjYRuncSaXYTIZwUwyA8y9k=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJ2S-000000006Qt-2zwf for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:28:06 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso219590f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 23:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795159678; x=1795764478; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YitxeEqJjeuuQP2ExFX04K5fMURIXK9L20+ha+ziMJA=;
 b=eC9gXj/U+g+1rX24tCPznUO0zy38kcWi67oq9umLZYn523D330312DZOpqGuYSAvv6
 CbAF0AUSUKHwo6sqgQa1l+UjkWnEsdQNfSK41YuXno+tiMzhyNsb1XjRhfW34cDNaTgO
 fCTFr5EQA40GaHlgYbA1RT3wIC7Bnhjj+th/OXDUrzAZncfY0tUP7wfbmmzZD+abMMuf
 ds64KguliaWg5agRg3KBW8jQEyCJ5CDES4B9EBGbMwZztsV9Nn9idqmmxSRl47xtYaPS
 nfnL8FHwXcmbxA/ycRYDEqRpzhVet68Ih1w1vx3eSZ1LEAz9AIYXtj/aMmExfbhBOfUZ
 tw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795159678; x=1795764478;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YitxeEqJjeuuQP2ExFX04K5fMURIXK9L20+ha+ziMJA=;
 b=G3g4owZ4gq1su+WwWh00MQk9Ekq5+EIWlgLd3adHtcEq3mm7NUwFzqdgG+2wEqPjob
 fPPqXQy8GJRI28Q5gv/BtGxh0WmGjq4ITr+wBW7EZfu9dAxIGbjiR+cwQEkUM14yyfCS
 sJlVO0K1W2xnN+oIniazCsCS65RTqCfGJToUtoR4LWSSdcDcqTm0f0LDQh/x7GuH+4sY
 t+Ksd5y8/zHzV5jBKm5FsoKyz7XTdfDiEedz1mGoJU/f9bUBr/fHNQo86iTPN6JSDCUs
 m1PHLpEJN6GNFCZx8ZdXrMzVFxAKowiofA/nxOVACq+CTlDdk3g+TDDrTkbFrHBNlL3g
 16og==
X-Forwarded-Encrypted: i=1;
 AL+hErErI0lC5OrA87HholaVXcL9c4D4Q6iHLCV98pIt4vCnzvJINIOiFOEjLxunzqzeFmiq+n62fZIhYuR52V1k@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+x77P2sSbj/ghLXTYePCTZg08OyD1xRQHURHRiQqy66I4dMQXl
 E7yeB4APNHOkTXK4QpfLSkpBtA1owm7lutO5lbLlx++6p30WcDk58+mWpRJe18ASVY63Kvkbfa5
 3mXE6/xXQF5efxffg+iTUsOXp8mxJAqx188hmbwB4NtTw8TX+25kYEGTeKCYPRyZFPZ2TFaexRB
 a2h0xFGg==
X-Gm-Gg: AZFdTZdYtv+UJn7g4dzdIzNSKVYkbaLWEbWSWosCHPjfwJZMx5AfPgYeYg2Qd4NAtIj
 sujZdPR3miGdjMAq1N+Zu1biHJdFvReqSLssMLaVDrUnqsJh5vS723fT69158ZzflBk2IxIFchT
 6k083WF/7HhG6WQFw0GbHJLNhwf31BRKBpvDbsWH5IoDVXtN98ZhiysXFpOBEM2T5/sOfhQwHOs
 MqooXJUUVfBASkoEHl80YWz+BKLi/whaSYY3zdxg0HLe5tjgWFzYQ3TthNO1U/5zEvCqWpVFniD
 rogqQi6eQZ5ACfPaFyIxu4tXEYg3+yvK8C3ZOzFrvMUaPZK1NmdrwuO/yR0zFwW5A+GwpVJDS9D
 2ayTHLa+kTcRuxTKWthLL1KcN87Bk9sjNrU4l3l3/ooXu2N3kUpcddO78PGIFdpGc2X7avkVqep
 n0/4N0zZflGu7zHmXkEMERBq5543BOQCY5r1I0qBgZ03xHkwjv3FZmHJj9FMa4xBQFc46NiVmL9
 3R8O9GjmrGu11aber3eL/8q0+MYzrbAVOqaTi/od06kJ8FqyDj7OpJdx3JloZk7HrvHwcB56lb/
 JQ9WWDOObOOYUSgS8m1flBk316wddrst7ZYBQCe86n4AoH6GRlASYStn9QPZ9lTxfOf7vBiEmv9
 ChvMrr+N2StipLhDaHkqgsitg/97++oVnsonA/KgoZ0y9aQHWSWnHqouIYW/Tf4thameY4aKhYz
 uI72BioGs2b/Q2m7so
X-Received: by 2002:a05:6000:310a:b0:491:286f:8e63 with SMTP id
 ffacd0b85a97d-4abaf7401fdmr4135642f8f.14.1795159677978; 
 Thu, 19 Nov 2026 23:27:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm4201985f8f.59.2026.11.19.23.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:27:57 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 07:27:56 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 36f8ddaeb2cd952fb137a9322d5340b47799c9ea
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 07:27:56 +0000
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4d5e1f9c414e17f6275286570e74af4adb4486c4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUJ2S-000000006Qt-2zwf
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: locate the UDP
 header via the IP header length
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7689945634508559856=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7689945634508559856==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oP7XaeUVBhA="; charset=UTF-8

--oP7XaeUVBhA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Lev Stipakov has posted comments on this change by R=
=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?us=
p=3Demail )

Change subject: dhcp: locate the UDP header via the IP header =
length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2209?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Gerrit-Change-Number: 2209
=
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 20 Nov 2026 07=
:27:56 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--oP7XaeUVBhA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov has posted comments on this change by R=C4=83zvan =
Cojocaru=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: i=
nline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-R=
eview +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2209?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; paddin=
g: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2209?usp=3Demail">change 2209</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2209?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e=
4fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2209 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 07:27:56 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--oP7XaeUVBhA=--


--===============7689945634508559856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7689945634508559856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7689945634508559856==--


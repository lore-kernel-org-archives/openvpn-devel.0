Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C1606A321
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QOpsdqd0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bSIW/6um;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZMNuNXXA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CiOzEnjB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WHnMzBMghToOlS3A3i6/IE97aCj5jlQWTOxD1ttA3ss=; b=QOpsdqd0OSrRZ5Wgms6SYOtvB7
	1oLxm1Euy1B3yFqOetXFF6AOsx1OlpVdHZr2Pv3XxLl2ZSkzQhcAgkJwN8S5Yi6iq6+nWto4kDMPj
	LdBGfoMMo31+nmg8Lb84W8533zA9T70BcHpbRr9MdSS1UkNu/grMI31Xk9vDxwHDf+n8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQQW9-000000006tN-2Nkk;
	Mon, 09 Nov 2026 14:38:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQQW7-000000006t0-3oNt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 14:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XxUnKH5Je8tILUj2J+GxHwx/CyMh1j+/WzkTSh8dM1Y=; b=bSIW/6umG/qwnQ5YRHfqBlTuNb
 6gp6wzGWFW15EsKLMMlDM292oCjqSpmTakl00BMzTg5UdQwCc7MuDx6kIsyuq9N5si3GRpO4yam23
 nx2qwMU0/DSMOBgywJIpYACCgOj9xbkX0NewOEUwcvWlP3F/MkGPZxbl6uZAkmJH1HmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XxUnKH5Je8tILUj2J+GxHwx/CyMh1j+/WzkTSh8dM1Y=; b=ZMNuNXXA9Weawr/vNENuK/Nl7U
 Rb8jU/TE5bstr0QiSsY55ekAxcvbKkjCorvsj1KXwdOqNqIYOwwxwT2latknDetOomdTsPJYyQiBH
 Tn5a+rBRavjinRyHm+R3U8KEbCnYUGHf5wSvsBPGyFkTTI7fjYd3+yweTfLKqs8kFtAk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQQVc-000000000U4-1v3I for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 14:38:09 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so9913455e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794235082; x=1794839882; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XxUnKH5Je8tILUj2J+GxHwx/CyMh1j+/WzkTSh8dM1Y=;
 b=CiOzEnjBMQyQdM9afBptUAQcRL6p1jUwr5VRhOaJZcIkqTWr/YyvU7pglesSXKV6lh
 p10azMDrp8RQplqtHiUrAiVlxecYPB9Uwrw5T51U8yirgbK4sNj53rHIxtRkBwghaUG8
 DMRcjU4nS8eCNgWp8wVRqFZ47V/E+yAylsHIFtVnKo/qw3SA9UGlAdGA6foiaqxgnWeC
 fPJmQoCBnnM8uJALlY+0++1f2t3q0Y9F2j2bM42g35FIpmwNrbFma8485baNn+ON1mnn
 CUHpLVWpe404rxs8iBRVqYxy95NgYSLPy70eQLczStBdMzAcJxLyvldC83IzGKZ82sh5
 sOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235082; x=1794839882;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XxUnKH5Je8tILUj2J+GxHwx/CyMh1j+/WzkTSh8dM1Y=;
 b=q6oQf52ZJBbqjMNFe1911tjMk4qtC2hra7RtMVZ92fHnsi72vTYl8No1Hsb8pHq3pA
 u6ZkE79Kcer1hUzrZxo5FXAZxAd069ntvvX/frW1z5B4jWBKMm6i83EJCshabFOZLdeb
 sit21vGjcPqixSlLK0nYJlXc7n0YLegvCVdNLMC6iGI852M1aXzT45iD7C/3vO5OnpdG
 TF2e30Z286gqMKX+IunYShzkGolNtNgYBjRUn+qLXhYlXLN8VaYj1xHm3kiF4aB8gSZx
 CR+J3PuolXWdH8skSXfvZm7PbtBZvJXOXHeWMtv8xzd2ua9vnD2IqItVnOCI5eKO+nOQ
 jVpw==
X-Forwarded-Encrypted: i=1;
 AL+hErHHyrFiaza9PYzgKki5bGp4XUGEwGvA1rx1LCUZmN9fcvXxMSgaUb7RI7XBp9a03ztQSh5Y2BTevLVFLsJg@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9iA4RPRQFF7FL2VSXcTlShXmXQ3nsAOA/jXyDTlc+DB9IV/a/9
 Mim5MrVS1Lf9jiIFKfOmdKqrxfMX56KxYeauP5EsRa4qhluItpKnxxq7Cv+uXuUtrjwStZLkv2U
 gCvf7bwqs3YmmwjzEwvYnLqcLLki86+ctJoaELhbjwaiOgsFIBnm/Wtc6TKLqwUuoeC0Vk7HoQ0
 o7Vx6pcA==
X-Gm-Gg: AYBFou2FG/wWreebTZ9K9Ln6O11vG58T102F229yVj8/hmU7Ne90fcgrl1SLerwmNiT
 OW8l6yQ7aYErDYX+7KwbwciKr9HKvCAMAmlubV/yF/fhPX1ug3yX8zRDMzY9eu2uNfZ0Tq3iFPQ
 8TE1Bulx2AmjVQac/xzWNLvD/QxpOxLAbrtPsnEXpKWVeT2TjMmqalCmKB7/TtmcZ5rN4z+STMT
 a/nRHEqtQUVDDhscu0DWonKrPKIpg4gXp5Tl6dNOsuOAOBivLOTJIJpadwUaCfswCMYID/XasDp
 8Lz1NZVd0MO0vb/CT9JILtSRzM8GjwLRs+rit1/+jyHqQ4PMnU3BhRKPF52/H3MpOLiGYcfONpx
 H5NM95c4WOa1LcZS95NBEuFdoTWmJYVfXz0dHqpQSNzykvzuKU0LZxb9LCSXZgc+IVTh7M/1w2j
 GFNFlr7HXukCWN0OCBVay4xHbB3bByXLT2SWcEI0+Rr46D5UGQ0y6hnVrXmeL/1SHwoVKYbdK76
 sKrRrYRR39GX0V0dUKbBWIb/ToYtheaRDNFvjenFI8aIm5hLZ7ngypdG4UrHhLGzjgvELh0htMu
 lIeuHt1+fIAkW87+PcLNSQOvbUs9SUnjrNbBVxol60lHEmCrGflDsMuRU5S6AKg2QgjWWzOB2GO
 r4Ea6sq2Bh3fjJm+vidzim7lFf6y3X5fAKKVk56VZMbNcXngco4R6M5lUbC8LcrUVBoY3BoU55G
 vQFfqDsQwLAAehFA==
X-Received: by 2002:a05:600c:4e14:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4b963c75d16mr74169755e9.6.1794235081520; 
 Mon, 09 Nov 2026 06:38:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959011c995sm10350758f8f.0.2026.11.09.06.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:38:01 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 14:38:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
X-Gerrit-Change-Number: 2144
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2144?usp=email>
X-Gerrit-Commit: a2af48f89c00c1de24770fb4789f7cb5436e98f7
In-Reply-To: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
References: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1ODAyMDAwLkliN2I5ZjI5OTRjYTgyOGVhNjk5YmM2ZTViMDgxOTNkZDMwOTY1OTI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99c219a57bad68d7458846c1cd0bdf1f2d816fd4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQQVc-000000000U4-1v3I
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: close
 the NRPT base key in HandleDNSConfigNrptMessage()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7923298182543592430=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7923298182543592430==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EbqXO5T/Z84="; charset=UTF-8

--EbqXO5T/Z84=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2144?usp=3Demail )

Change subject: openvpnserv: close the NRPT=
 base key in HandleDNSConfigNrptMessage()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: close the NRPT base key in Handle=
DNSConfigNrptMessage()

The key opened by OpenNrptBaseKey() was never close=
d, leaking a
registry handle on every NRPT add message=2E Close it at the c=
ommon
exit, and return directly if opening fails, as the key is not set
the=
n=2E

Broken since 0f3b7d17 ("win: implement --dns option support with
NRPT=
")=2E

Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
Signed-off-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
144
Message-Id: <20261106162251=2E2926-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg408=
30=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/o=
penvpnserv/interactive=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)

=



diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interacti=
ve=2Ec
index 6a83bac=2E=2E81205d6 100644
--- a/src/openvpnserv/interactive=
=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3014,7 +3014,7 @@
     LSTAT=
US err =3D OpenNrptBaseKey(&key, &gpol_nrpt);
     if (err)
     {
-       =
 goto out;
+        return err;
     }
 
     /* Add undo information first=
 in case there's no heap left */
@@ -3065,6 +3065,7 @@
     ApplyDnsSetting=
s(gpol_nrpt || gpol_list);
 
 out:
+    RegCloseKey(key);
     return err;
=
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7b9f2994ca828=
ea699bc6e5b08193dd30965926
Gerrit-Change-Number: 2144
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--EbqXO5T/Z84=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2144?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: close the NRPT base k=
ey in HandleDNSConfigNrptMessage()<br><br>The key opened by OpenNrptBaseKey=
() was never closed, leaking a<br>registry handle on every NRPT add message=
=2E Close it at the common<br>exit, and return directly if opening fails, a=
s the key is not set<br>then=2E<br><br>Broken since 0f3b7d17 (&quot;win: im=
plement --dns option support with<br>NRPT&quot;)=2E<br><br>Change-Id: Ib7b9=
f2994ca828ea699bc6e5b08193dd30965926<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/214=
4<br>Message-Id: &lt;20261106162251=2E2926-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40830=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 2 =
insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/=
interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 6a8=
3bac=2E=2E81205d6 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -3014,7 +3014,7 @@</span><br><span>     LSTATUS err =3D OpenNrptBaseKey(=
&amp;key, &amp;gpol_nrpt);</span><br><span>     if (err)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return err;=
</span><br><span>     }</span><br><span> </span><br><span>     /* Add undo =
information first in case there&#39;s no heap left */</span><br><span>@@ -3=
065,6 +3065,7 @@</span><br><span>     ApplyDnsSettings(gpol_nrpt || gpol_li=
st);</span><br><span> </span><br><span> out:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    RegCloseKey(key);</span><br><span>     return =
err;</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=3Demail">change 2144</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7b9f2994ca8=
28ea699bc6e5b08193dd30965926 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2144 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--EbqXO5T/Z84=--


--===============7923298182543592430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7923298182543592430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7923298182543592430==--


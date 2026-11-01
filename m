Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794F606A325
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mq5+xpq4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mtz5YxKA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QuRxI97W;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VAkvpGT0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JN10N6j6UW2of/Gn4WJng4YQIo6S058/zj1hj6dMFEI=; b=Mq5+xpq4/ltVW002TzoZRNbwrp
	t6lgZaUOA1U56fWtKimjYb706KYeytdhGs/QKlC6EK6fRUMqC9Ec2X6m7K+X8hX+XoMc+XOarp6aQ
	jcjJ92isotlBiQex+GRIF78/gYXnIwaJHqgSFeqn5xQWx/DDeCcoi0jbZ7FV4ZLHCQhs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNTyF-0000000086d-1XCN;
	Sun, 01 Nov 2026 11:43:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNTyE-0000000086R-0Alk
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Yg/FtR3ucsSUDy827sMSEwTzBHd199NHffofULh+Lc=; b=mtz5YxKAHpG9AwzGtZ6XdBAdRe
 BxNvWyeVx/egP5BZkI+eXHXXuyu0lryj72ohdgiK2fnUh4KkeO+EJIQmzLKRm2KAaurIs+xUvBQ7x
 0GGfBu6UlH0HlwmbscHFp/WFhccOMlFIQnxtWSYHMqN9k1cusGjHUnCs+N9oaM4QgHjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Yg/FtR3ucsSUDy827sMSEwTzBHd199NHffofULh+Lc=; b=QuRxI97WG+QCYn+zx4RVuEJ5J/
 zv/30/hc3OE4R4QTLvV8oeRmOgc9L7zfzHl905NlXFysM/Fr+bsZwJYtjTyWKTF1g+T/URNJ6QUMw
 LxIezN9qZAA7lP2gxazAKJXXG90VtrH2TU3pAURef8M964f7Ni5C/bMy8kAobI/Sd8cM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNTyD-000000001xd-0R7Z for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:43:29 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so27139165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793533402; x=1794138202; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+Yg/FtR3ucsSUDy827sMSEwTzBHd199NHffofULh+Lc=;
 b=VAkvpGT0fClZofOaJCIrPaU1Hfehb50boThxX5pQuFq+Or2PCEMM48yjTUaoODdWxW
 TDioPpGkYmXYaKxWMDnsMskeJo5rz21D+DhOlrylSxml0veZKAR20c6DcWX17ZTNM12/
 WpnX7yMS7FyMgYLGAAofPOcmfz/5/QGd0c4n/kUbznFS/GbBqoAhvhcoIZ3ZFZ/LdJ7F
 KgKL3Y6SvEuswooU5Cnky3BHFErCud5ooVoSBHDKA6+EXQ50f+jVP4zX0b+hR/dVSUK4
 KuTby4wXu/7tXPQzHyMvSUIqfm0CPVhHC9iGyN0jG6HN2fg7odHve2dwBZxhKCjMelmE
 it2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793533402; x=1794138202;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+Yg/FtR3ucsSUDy827sMSEwTzBHd199NHffofULh+Lc=;
 b=zpf3vCTXAxNWc3Wk6woeLWajxMxoPZr9F3JNUPb2XaD0wIICMd1AKlmrl9GY1cMeZq
 rUTpq0b7A2UX0vtzBzBFvLH2nBf6Tokn+ZooLs33i6iEwtAlu5C+xRLjDDvF/FnxyufI
 ouizwqmzL2sGwXT6m611ifKCUSRDJB5k6DDW3GcKa7wssxxYnzWThpZbtLqfHHRW8P75
 w9f9JpqVWFXCuOaRC6xdjxi5X7CTBkfSUKpnbrPDaWXmB3ef91qc2EkDC2ZAwV/s8jaq
 QPoBBStG1KWaFSeR+kpPZJK7mwKf0N1AmZj34x6KEAp1Hi5WSbFWI9+mfhAeJnT31byn
 w3zA==
X-Gm-Message-State: AFq9FYKTHU+shIgRVQys0fNcOqhH0ZKt7sF4aL1ypyImYqSTu36117Wf
 zk7+z+sv8i4MxSEQQRlMRrKTwZ2HCWzMHPwDs/U0nrTWAr2LG0+LKO8cvFnvuOZw1lXt5OxrWiG
 5OV+cGtiQA1tDQceXz5sVT85GJyaAmyVnZfe4e4ZXq5qLEEVeDDM0MuyrMrYq4+A5ikmF
X-Gm-Gg: AYBFou0SV39RHfvh63Sc4oKMRV+huD+utIPcl+TIxou7J2uRvNL4bhnymMc7txerzDD
 W092o3yuNx/tO7QWgpIq6Y0nY8pP7P00VvdbAsQbmr1LzVv5lMv44Mfyf2qpxtvgsKOb4D8LpBW
 1nJGBZSLpCX+h+4g5P4B3qxIx3FkFALAVdC97g+gh0uVCLCY2rZEjAITi1QOyNVoZTYSej0PkPh
 ciTVRMbNL2OkfmLgs4D0BczVSXSrXwAnM57RiiqHBVqpBhnoz9wcZsafEI4a67cAtY8LRUvCycW
 6zjEKnu4eAy0Zt2cAf0LbIvuGwQ3FHPOo0ycka2LV8mudW+G0EXNPkayEEWzr/INRSDlFMMUE96
 9pRiIyQJeU+easvsxpuLQFQbzNRq5NdOz1VZdTZA8opL5jTxDHEpTGWtAE0n8apIQnh+6nzTqp5
 29iOIKjVMNk8JrqgShsp8OuT0xhOPmT/gqnGI2+NX/StMCSrTHDTJuOO4HJROBAHL42pj5CMYnI
 OFcGk7gPTjI37JzXdICMqdxhooufRHSprDSjxbzB6n0F6N24qftyQKy2WQ3VHCG4xRbDW+Qk649
 4Rq+DJ6glbVlyNaeXY4kbLyGXBv1pU9gEWVUYlys2GC/Sw+VdKHPITlO2Jb+ddNxQ37Kbrvwzq4
 10ux/n+s3Z6EBm1GIGkvQVEeuYxtBoUJHhi5DZhuWDQH1m+9qRx6jIZMgDZuuGRwAyHkr/vDMrZ
 dNg/LgZkA7F+2T7g==
X-Received: by 2002:a05:600c:8b48:b0:4a8:a341:2377 with SMTP id
 5b1f17b1804b1-4ac16acd9d1mr181193585e9.3.1793533401903; 
 Sun, 01 Nov 2026 03:43:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac08b72578sm83907965e9.2.2026.11.01.03.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 03:43:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 11:43:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
X-Gerrit-Change-Number: 2067
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2067?usp=email>
X-Gerrit-Commit: dd5cb68395e4e2d437ad727e0f2dffa899585158
In-Reply-To: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLklmOGFlOWNiYzk3MWY2MDgwMGE5OThhYmYyZjk3ZGEwMzg0YzAyM2YzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bbca416fdd71e312200c87051e1316a6c655a68e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNTyD-000000001xd-0R7Z
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not hash real
 addresses of TCP connection
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0968278093697138329=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0968278093697138329==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1yJXZhXSTHM="; charset=UTF-8

--1yJXZhXSTHM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Do not hash real addresse=
s of TCP connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Do not hash real addresses of TCP connection

With neither status r=
eport nor max-clients depending on TCP
connections in m->hash anymore, remo=
ve hashing of TCP
connection=2E

This now allows an obscure corner case of =
two TCP clients coming
from the same IP and port to different IP or port on=
 the server
but as our operating system can handle this case, we do not hav=
e
a problem with that either=2E

This has a small added benefit to keep the=
 number of entries in
m->hash a bit smaller=2E

Change-Id: If8ae9cbc971f608=
00a998abf2f97da0384c023f3
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
=
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2067
Message-Id: <20261030134023=2E19798-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg40322=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 11 inserti=
ons(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/67/2067/3

diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec
index 0366c11=2E=2E3f82052 100644
--- a/src/openvpn/multi=2Ec
+=
++ b/src/openvpn/multi=2Ec
@@ -2486,13 +2486,22 @@
 
 /**
  * This sets up =
the client real address (outer tunnel addr) in the
- * hash map for data ch=
annel packet=2E If the address is already taken
- * this steps fails
+ * ha=
sh map for data channel packet lookup for DATA_V1 packets=2E
+ * If the add=
ress is already taken this steps fails=2E
  */
 static enum client_connect_=
return
 multi_client_connect_real_addr(struct multi_context *m, struct mult=
i_instance *mi,
                                bool deferred, uint64_t *op=
tion_types_found)
 {
+    if (proto_is_tcp(mi->real=2Eproto))
+    {
+     =
   /* For TCP connection we neither need to be able to map incoming
+      =
   * DATA_V1 packets to the multi_instance nor do we need to ensure
+      =
   * that two TCP connections are not using the same address as the
+      =
   * OS takes care of that=2E */
+        return CC_RET_SUCCEEDED;
+    }
+=

     /* If the address is already taken up by another client we fail the n=
ew
      * connection */
     if (!multi_check_dest_addr_allowed(m, mi, &mi=
->real))

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
7?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If8ae9=
cbc971f60800a998abf2f97da0384c023f3
Gerrit-Change-Number: 2067
Gerrit-Patch=
Set: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--1yJXZhXSTHM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Do =
not hash real addresses of TCP connection<br><br>With neither status report=
 nor max-clients depending on TCP<br>connections in m-&gt;hash anymore, rem=
ove hashing of TCP<br>connection=2E<br><br>This now allows an obscure corne=
r case of two TCP clients coming<br>from the same IP and port to different =
IP or port on the server<br>but as our operating system can handle this cas=
e, we do not have<br>a problem with that either=2E<br><br>This has a small =
added benefit to keep the number of entries in<br>m-&gt;hash a bit smaller=
=2E<br><br>Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2067<br>Message-Id: &lt;20261030134023=2E19798-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg40322=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file chang=
ed, 11 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/2067/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>ind=
ex 0366c11=2E=2E3f82052 100644</span><br><span>--- a/src/openvpn/multi=2Ec<=
/span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -2486,13 +24=
86,22 @@</span><br><span> </span><br><span> /**</span><br><span>  * This se=
ts up the client real address (outer tunnel addr) in the</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * hash map for data channel packet=2E I=
f the address is already taken</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * this steps fails</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * hash map for data channel packet lookup for DATA_V1 packets=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the address is=
 already taken this steps fails=2E</span><br><span>  */</span><br><span> st=
atic enum client_connect_return</span><br><span> multi_client_connect_real_=
addr(struct multi_context *m, struct multi_instance *mi,</span><br><span>  =
                              bool deferred, uint64_t *option_types_found)<=
/span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (proto_is_tcp(mi-&gt;real=2Eproto))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* For TCP connection we neither need to be able to map inc=
oming</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * DAT=
A_V1 packets to the multi_instance nor do we need to ensure</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * that two TCP connections=
 are not using the same address as the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * OS takes care of that=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return CC_RET_SUCCEEDED;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* If the addres=
s is already taken up by another client we fail the new</span><br><span>   =
   * connection */</span><br><span>     if (!multi_check_dest_addr_allowed(=
m, mi, &amp;mi-&gt;real))</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">change 2067</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If8ae=
9cbc971f60800a998abf2f97da0384c023f3 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2067 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--1yJXZhXSTHM=--


--===============0968278093697138329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0968278093697138329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0968278093697138329==--


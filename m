Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3251606B364
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S/d15i73;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DM/PBTK3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cn5yh5ji;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PDfZBX77
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cK5ntXzYAEO0chyO+Jq8LXuQ0IMUQ71GnxNg2I22kBw=; b=S/d15i73ZmP5xqBda3fFrOl+fi
	kktySUvtD4mXPgY0xwTlaDvofp/R2W4MwkSlNIJ2iWy+f+Wv85QyjbaMBDao3xTdzymUKIvZle315
	pAe9lfy+C4UPo2E288f5IYASbOJG5eqI9Hqolt7G1VOglj9I2qJsuC4G/s068yHxnnuI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRmyf-000000001x3-0qHq;
	Fri, 13 Nov 2026 08:49:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRmye-000000001wn-24Ow
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 08:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pMaINIMyH80fSmpC9bZtw4pkgCh1qvPzRlZiwJ0HcCA=; b=DM/PBTK3A5y0plWjhLZhjp++ru
 SxGlOt9vAATBqVdGZsTRJbAj/sEApZNnL8IEj+84qMwyfR0zCFVPQUlCGHiQCtjSlkhU9lZBBR85Y
 zV84WiTde8xW9Ni4aoKxn8xTX1dqDZSXOyjNYsky3TurzLjteZdXHrXUFxH7hmLhI8t8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pMaINIMyH80fSmpC9bZtw4pkgCh1qvPzRlZiwJ0HcCA=; b=Cn5yh5jiTpscdnK0CyCVAtuv1q
 hWjSqfSOzr/PeVWYDpMY2casQJXlnyAKIbq+kDoMaI7Av8jEic3iRygwTbPa1Gg2+YCuo8tLrrCd3
 l/GIdAXw987/YdwH46xlv0xsTwW2tBVI93jpQaPJpjDROID4VowOs/DtkkHVspz3Z6oo=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRmyc-000000005Ik-3Gpu for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 08:49:44 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so4898535e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 00:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794559776; x=1795164576; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pMaINIMyH80fSmpC9bZtw4pkgCh1qvPzRlZiwJ0HcCA=;
 b=PDfZBX77EJGzY8M7WFYDFKQb7Bkx7AvtjJq564RqyB1Hfsnhfmc+aKgLNrw1bp1RcA
 KFqodtPHEx/RI7Dvgs2uIMhQ+/uyzZ2lsc1BFdGPyaTCmY2wBL3XqENV6FBHgfy/btwU
 EzmerL+VTnbDT3hLgHLcKohFzdy45cS6jenl2pykS/Ximh17s2l8gPPSQA1wP+q/bDRd
 pF5gZjJ3xTobYFs+2eWh6UGOAnAjikXlyp8ACAL7G90fRqkC76MPW6vgXfwG/wkHSX59
 zs5Svk9s1j9WtVVJCb5nuAskd44uA2zZRxQIIxpaJIXwsNZabbOaRJK0U7mM9uHCgmC2
 w63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559776; x=1795164576;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pMaINIMyH80fSmpC9bZtw4pkgCh1qvPzRlZiwJ0HcCA=;
 b=fwmvklvijKb6n8NUxJsiROsNSX+uXDTjhpXll8g1SX7ME5n5V5bAMUXqDVughAAtmY
 5gBSO6Ab7BU2rkk8H7Cjp+6phfWppXFO3cpjJtTM6NysCS6xcu94nyaRKy4B7JjuwLXy
 p7qCk+4sp0OD2XPUB3G3QyshYBdYuOGxoYAcH1ye9bD9FWyfUpCJ1oyfSZxMMMz+6hA+
 NgB+yH5yZ4+2e8KVbFOLnsmhzScfIgkaqBi+Y3bnhwN8qmYz+XmCdakhIIvQk1LN/sa9
 kIBdxxAEE4MB2u6SEAGRgp0RPltYc3l8WWdpt7JSELcY91Ej1yT/rYOySVRcJ4NR+Ctf
 jQjw==
X-Forwarded-Encrypted: i=1;
 AL+hErF38aS4HaGYKj/8hFmLgQqS1ZIr/8JgUiG1XEpEXqxFeynPjmJKtHDSxiA01dlOjCArm7lM/96dc3ZHM+U9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/FGall0SHdthOx/4pDM7IY5jbC7CWc2TIWhfQ12cyJ8H5HgJTr
 vmao5nV37xu7p56G9lLO8HZ9OsvvB0rr/hwkurIZZvIDCgdW/S2bGFTP5nQrah5T9ERNG/42ECy
 7q9e7b0ydl3uPFzVNaw0J2vAew0DGoIOVVQOJrNn27xFWOzg4szIt63v6Bce1Jg6Ptmbaf7CLef
 oCwgsNzw==
X-Gm-Gg: AYBFou1ZxHrQ2mRxSi+3SySQnEHGnudRlH1ETPosr550HzIB6YhVsNDwV0LtcQT+rNJ
 6yBITXafp7vrwUGqCY2VZJIMxFEz2elXvdfFppvruaU4i4b+lorWp6RBdQNQuXhgY3hR9Ba8tPl
 ihgeodfrSJ60XnYw+MD1noDsbltuRZrlrLrCQJTEyZYYnbvOIHK0Lc+xevpXxBih+0i3e4FZmM3
 tTarc550VSJvkrFpDpLxISO2LgEaLtUWG89XwVBmpIkjlbnBdkgcE+cmwrF16GolbLK7xx0lvVK
 EeQuyxa5d8oiisOi6u2EF2l20iLwhOPrHKQLQBIwMTbBi3AWiManluvCFdtFL/m56kt9/afoLdK
 Q2Ar6RDliWT+Rj3eKmWR//pWej8eDcf4YVNAIMJ2NP4nakaXV4TVJJpLpmoWEYiI5KQ04FV60yr
 xIdIEfetsZqVgs1m2/hxdVuChNbRcz6/lClA5I7DuhVCDOEbtoO2iaLpYQzwJJcprbLLTQSCMBt
 CnAsTfGlE+1FWZrhsYaoF0JM01R70O6ITcpt6B1C0B5TOL0QRQVpb1KPXsYq7+1d80gRk7ZH+Y4
 VZC/tB/+6lPGsnFwuqJJaSxavEyWMYevDUc1Rk8NIH4ehqpJBPDvzwciQV0o+n1c2ouJCYB8HMU
 dcXJA8iMW6xi4k4XGZ95gdWo5DWDTyHZNWTOhf/PvVV6tutHXrhIwY/ODO3H2rOvEFAPSLogUQX
 GJG1Kn/K/nXFyE5D4=
X-Received: by 2002:a05:600c:870f:b0:4ba:495c:3798 with SMTP id
 5b1f17b1804b1-4bb55af1377mr34381065e9.35.1794559776031; 
 Fri, 13 Nov 2026 00:49:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb566220edsm60709755e9.0.2026.11.13.00.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:49:35 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 08:49:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 7aedc6fa5691436ccd65f17241fb66478b785b5e
X-Gerrit-Comment-Date: Fri, 13 Nov 2026 08:49:34 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c896122e08492d7f6c77c72a6c77f228620af88-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRmyc-000000005Ik-3Gpu
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
Content-Type: multipart/mixed; boundary="===============6451625901383558101=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6451625901383558101==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YQSEzqOKib0="; charset=UTF-8

--YQSEzqOKib0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Lev Stipakov has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 7:

(3 comments)

File src/openvpn/control_msg=2Eh:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/65473952_745b4002?usp=3Demai=
l :
PS6, Line 45: /* TLV header bit layout of the first 16-bit field */
> S=
hould this comment be above `CTRL_MSG_TLV_OPTIONAL_FLAG` / `CTRL_MSG_TLV_TY=
PE_MASK`?
done


File src/openvpn/control_msg=2Ec:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1965/comment/a97da6c4_e2770988?usp=3Demail :
PS6, Line =
62:     int field =3D buf_read_u16(buf);
> Checking `BLEN(buf) < CTRL_MSG_T=
LV_HEADER_LEN` first would match the write side and not partly consu [=E2=
=80=A6]
done


File tests/unit_tests/openvpn/test_control_msg=2Ec:

https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/7ba74c6a_8ba30567?usp=3Dem=
ail :
PS6, Line 40:  * client to resend its WKc, as older versions wrote it=
 by hand=2E */
> I think Arne -2'd this in its previous version over this w=
ording in test_pkt=2Ec=2E [=E2=80=A6]
yes, done



-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Ge=
rrit-Change-Number: 1965
Gerrit-PatchSet: 7
Gerrit-Owner: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Fri, 13 Nov 2026 08:49:34 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>

--YQSEzqOKib0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov has posted comments on this change by Lev Stipakov=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3D=
email">View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/contr=
ol_msg=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/65473952_745b4002?us=
p=3Demail">Patch Set #6, Line 45:</a> <code style=3D"font-family:monospace,=
monospace">/* TLV header bit layout of the first 16-bit field */</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Should this comment be above `CTRL_MSG_TLV_OPTIONAL_FLAG` / `CT=
RL_MSG_TLV_TYPE_MASK`?</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">done</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965/comment/a97da6c4_e2770988?usp=3Demail">Patch Set #6=
, Line 62:</a> <code style=3D"font-family:monospace,monospace">    int fiel=
d =3D buf_read_u16(buf);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">Checking `BLEN(buf) &lt; CTR=
L_MSG_TLV_HEADER_LEN` first would match the write side and not partly consu=
 [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File tests/unit_tests/openvpn/test_control_msg=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1965/comment/7ba74c6a_8ba30567?usp=3Demail">Patch =
Set #6, Line 40:</a> <code style=3D"font-family:monospace,monospace"> * cli=
ent to resend its WKc, as older versions wrote it by hand=2E */</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">I think Arne -2&#39;d this in its previous version over this wor=
ding in test_pkt=2Ec=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">yes, done</p></li></ul=
></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8=
146 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Fri, 13 Nov 2026 08:49:34 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body><=
/html>
--YQSEzqOKib0=--


--===============6451625901383558101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6451625901383558101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6451625901383558101==--


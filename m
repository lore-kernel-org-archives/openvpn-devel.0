Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC18606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=myGHgdl6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mAKBQvcT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KF/J8gTN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ByXhURAB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dXt7haiGcetq4G2H0FN1Zix0je+WyYuSCrfkaA5MfUo=; b=myGHgdl6uFZljcXIrit+cAk2J8
	2M41fyvRep3Wi7eu/3LuN0w1W9DmV7IG4xpoJSGt9xZshBfqljhB97HwVSowWtG08g1lsItopaP7M
	l0g5j6VPfa161sVEm4ooh9S5IQkZFyr+D2UshGgHGG9cJNG7ED9TaiinOoA0dLVmzGN8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJIs-000000003Fy-3P3r;
	Tue, 03 Nov 2026 18:32:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJIr-000000003Fr-1oMN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:32:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+ZtLjJ1yPXEP17x0HITb1Hen6dV67WmVoFBIC275g5w=; b=mAKBQvcTuDk2RxmknjmLONM69V
 8zvrFCf7Zhp92DoBpAWI6KEtAcX8EMmoGDVP3IPOYsacpvAqX0cngNAEdGS4zfcq/uBTJZUWOgYmH
 23nGYrc7oE04xe/5cz7TQ/qDV0cgGi5yMFqcqIr3wrcj36oiB7KXPW5UZ+52Y+Safj1U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+ZtLjJ1yPXEP17x0HITb1Hen6dV67WmVoFBIC275g5w=; b=KF/J8gTN6rt5iu3zAeYyFiryMr
 SReNJvv38q0RQ9a8oNfz1R4/mRCIorRSJ3ubCaTVCm4QcsRR7kL1n7Y1iZ/YfUbQApcVE4N0fomg5
 +aJAiiaHxgO7jCOAXcH6vw4qjpQO0LFAxfLy7pn6l+ry1T0IMqxVpTYbLK2QaQHYMlDc=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJIq-000000002yi-35Qj for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:32:13 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso2310017f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 10:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793730726; x=1794335526; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+ZtLjJ1yPXEP17x0HITb1Hen6dV67WmVoFBIC275g5w=;
 b=ByXhURAB8Tm7Cyr8WlBUS1UxB826075LFzDrTS68a8gUwY5rvzq750s3dtyN0HeIWF
 d4VB1bew3ov6f8dbfCYsu37eK3FjiL5NJ+QT8MRuPEFk61ip1Xuo9Wj727eUt/EXp/h7
 gBHcgUcFY2nvqyhbFhonInm7HFdJjvIVxD19ZCUiFW+truuzgYxlhqyTTNy+Ne7IyUk6
 54VRyYxUp5LvYgid9VV1mR29tcHSRg6GkEXUuIpcy5Yfws22TndkHdoqZ/C3qBLH2rA9
 8q+o8fnNK9Gqjcl5ro3jqWrBlj2FbxWWywvSfqIjTmth6GGVE3AF6tqa0AKZx8l6ofK5
 PTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793730726; x=1794335526;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+ZtLjJ1yPXEP17x0HITb1Hen6dV67WmVoFBIC275g5w=;
 b=mPoOvvW2P1ZbFFzMieCvrMNKfrbIymycLKRbX8sLZ3Xj0lXYC5gbtqecHf88gHCit2
 wiwvaOIGOZ9ueXkWBuZw7i1vpm0sFpZFQjAfQQJl3sg0aWE6lFI99iBf+pHCBIy2KyNm
 ui8Ud7Gt4UhoJERkKGKd75s1YfLil0Pph68PQnG932QBYbvivejbt6msE/p/E3l1C+7P
 7MldCrEB2eOo6x74YyNYhQTRJAe96+jJrUgrBPjWDyqCi+s7HvHJd7YmFqwuwVtr54hj
 A1xOpLeuUR+NGcNvzCRfYrzJKh1UTY0v1nwRRGu/WauTFXYFzSdRPyiTfWKbX7KHXN1M
 IEAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZSpfhUzZKLypnuZcGoNKRT2JOGooDd04ah7vq0Aff0CIrWNtjFEfKBndB8qLXp26ILG/krs4KeXLcnz1f@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8oJsuMCiPcEAA/juhem/nKdll/xhkp50SPc/G6zfqi04ZnOo61
 O40pJscfNWuTDGTwrC3DfXud9jPIctb+admZjdDcirp5UxSkQq68fu13J1EW8XCd8Y/1eK974kM
 i82NZKv0wq6+ni3ePbUupQPwOPmZRWaYL90TVgw4yq+chVoObaPiYFxRNn8qwYNvh0QWC
X-Gm-Gg: AYBFou3vOCNj4SNisuqjz6nvxZcaj22ABzgfBZYW82CozSak2EF7DwT1NA8oTTF8oMA
 3EYDtYbnw0U5mQ3RU7miQi85rtuJ/Edb2kwIAzR/yiVASA84yl7No8Y1fHWjmiKGT/YAtodkfWa
 Yi3DRHwnawYeQnSFPJVMs179O2zHxiQUQymIuJDMIc3eul2xMBSlwE64PZB3nat4iQPHMjrZhqK
 ikX2DjnEn9Ki44ZBsPR1QqRNBssi4m3DoaQ6eurgTNQ8jf4GPo2YKjYZCWJpvgT/IN6NoueME63
 zqewbqC3vhl9nkVVH6kVA3xn1F73XXimg2H5YZGHEfmn37d2+2Od/tEYRHnYr4em/GXl8uIy+fV
 BufkThQb8OUwXAFbbjg4IjMOuJOmcKogp79PlegrHFpIrHqzE/tXejboBupDGmf+41Kop/dlCXc
 dFm+QYLinQyejMUxvFR3OPLV9H4hij8IOYXYOCJlJeE2BCg/Q+A1XDHrCXe1ApC4BG68/Nsnh2B
 1+t2QnHe0PpT8WORV42JVuvSWtvyIJ5IbPzHss3t174UMFy67Wic8++Ai7iLGjVbrBO6JIEgiIB
 Yc3sU5//8wp4NFVnar7KLDMz8mFlfR+XpMayvYhPaQtA3+kYL9YJ4s3vmzsM3p+r0cPbsJq5kJB
 IfuQStKpGWM4W2TBCGmrTp4i11c/3bObfOxFpONc8IQpPOWv11v7/guwc+DdexL9HhGGOw6B9lw
 gnKL2sH6f33McAR5uJfbxog/lrT3dYCTLBe8U=
X-Received: by 2002:a05:6000:468f:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-48e6e2fce08mr22728304f8f.24.1793730726092; 
 Tue, 03 Nov 2026 10:32:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm28293095f8f.55.2026.11.03.10.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:32:05 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 18:32:05 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
X-Gerrit-Change-Number: 2090
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2090?usp=email>
X-Gerrit-Commit: 09cc40a6ff9e1d81db463a7769c464dd2baecf1a
In-Reply-To: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
References: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI0NTYzMDAwLkk5N2ExNDA4NjI1OGMwOGI0N2UzN2YwN2YxMDM0NjBhOWQwYmI5YWZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68d4551dc9a9cf2e1e8070b4e9d15013ceeb8de7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOJIq-000000002yi-35Qj
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 inverted inet_ntop() check in GetItfDnsServersV6()
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
Content-Type: multipart/mixed; boundary="===============7561284875750246869=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7561284875750246869==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RnjHPdu6UHI="; charset=UTF-8

--RnjHPdu6UHI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2090?usp=3Demail )

Change subject: openvpnserv: fix inverted i=
net_ntop() check in GetItfDnsServersV6()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: fix inverted inet_ntop() check in=
 GetItfDnsServersV6()

inet_ntop() returns NULL on failure, but the check t=
reated success as
an error, so DHCPv6 DNS servers were never returned=2E

B=
roken since 0f3b7d17 ("win: implement --dns option support with
NRPT")=2E

=
Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
Signed-off-by: Razvan =
Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090
Mes=
sage-Id: <20261102170238=2E111437-1-frank@lichtenheld=2Ecom>
URL: https://l=
ore=2Ekernel=2Eorg/openvpn-devel/20261102170238=2E111437-1-frank@lichtenhel=
d=2Ecom
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpnserv/interactive=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)




=
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=
=2Ec
index e2f17f0=2E=2E484f27c 100644
--- a/src/openvpnserv/interactive=2E=
c
+++ b/src/openvpnserv/interactive=2Ec
@@ -2217,7 +2217,7 @@
             =
    s--;
             }
 
-            if (inet_ntop(AF_INET6, &in_addrs[i]=
, pos, s) !=3D NULL)
+            if (inet_ntop(AF_INET6, &in_addrs[i], pos=
, s) =3D=3D NULL)
             {
                 *size =3D 0;
            =
     return ERROR_MORE_DATA;

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2090?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
Gerrit-Change-Number: =
2090
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--RnjHPdu6UHI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2090?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: fix inverted inet_nto=
p() check in GetItfDnsServersV6()<br><br>inet_ntop() returns NULL on failur=
e, but the check treated success as<br>an error, so DHCPv6 DNS servers were=
 never returned=2E<br><br>Broken since 0f3b7d17 (&quot;win: implement --dns=
 option support with<br>NRPT&quot;)=2E<br><br>Change-Id: I97a14086258c08b47=
e37f07f103460a9d0bb9afd<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090<br>Message-=
Id: &lt;20261102170238=2E111437-1-frank@lichtenheld=2Ecom&gt;<br>URL: https=
://lore=2Ekernel=2Eorg/openvpn-devel/20261102170238=2E111437-1-frank@lichte=
nheld=2Ecom<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 1 insertion(=
+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index e2f17f0=2E=2E4=
84f27c 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><=
br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2217,7 +=
2217,7 @@</span><br><span>                 s--;</span><br><span>           =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (inet_ntop(AF_INET6, &amp;in_addrs[i], pos, s) !=3D NULL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (inet_n=
top(AF_INET6, &amp;in_addrs[i], pos, s) =3D=3D NULL)</span><br><span>      =
       {</span><br><span>                 *size =3D 0;</span><br><span>    =
             return ERROR_MORE_DATA;</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Demail">change =
2090</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I97a14086258c08b47e37f07f103460a9d0bb9afd </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2090 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RnjHPdu6UHI=--


--===============7561284875750246869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7561284875750246869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7561284875750246869==--


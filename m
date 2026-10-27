Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A7606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JdtTfyDW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fIMBjiFp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ONJAnNXA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xx60VYGQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RHHmlwHIeBqZtV4ixLS7BsxBy7v4OIuVjQkb/QpSYss=; b=JdtTfyDWFQR9CFyTtDHKeuv66j
	+9hPlnX4SQ2sJS9W8KzvJVT+AzpqjxPpI05Ul5smNA4vtZKQ6gEQWeAQGyaie1WsZqqebFf8jEe4h
	YXZaMLLVC+hjzXx/KF11o4gxAy0VQ0m2jiG5GAqoj7jFRig3Sisj9tOHvubD3CHTyDm0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLh4V-000000006eH-07AF;
	Tue, 27 Oct 2026 13:18:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLh4T-000000006e3-0SsW
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nMPj2ppS21jLEJLvzVMVJBKb4DfR1yzJLDf3gcwc9pc=; b=fIMBjiFpxaZc6Gy7BFba8PvYNz
 6//5v4lM//0n6tskrRwfQ8OqIjfoxVRhd3LiX5rE6nWSWuRyIXsnNUn3kASoR95s128p0nljanJYu
 rrhYuzgbDVHxTn+J6pJP4uvKskJOMTJyFwsF3DscXkpIEhvTmgq7XdRfaDxzKfRMtNF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nMPj2ppS21jLEJLvzVMVJBKb4DfR1yzJLDf3gcwc9pc=; b=ONJAnNXA92EjJUoyGh7+7QRkev
 alGhMc50aC14oJYVnEp1MQv43w136Rzsv0MklY+rRe/TkPcuyMJIEA5oU1KcFBMIka8DMgYrJ1WP4
 Pv7+JoyLYr7zaqccJAkOxTTZas4OoGEAA1sU78Xo84jvzFn+qXRxvRUBDYNETjOTAQ1I=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLh4Q-000000006sF-0tpY for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:18:33 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3482764f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793107104; x=1793711904; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nMPj2ppS21jLEJLvzVMVJBKb4DfR1yzJLDf3gcwc9pc=;
 b=Xx60VYGQlyVozjlcXU5UXEVrn8f7ZL8DueSIQe3usMYqa9hPttKn7c0rVmBM97sPBv
 9A17VUsF+Eeio+IMiW2VRimiGxoO2+WMhN27HhnahyuwTCfN28GWMLOd024yZ9gzbTsC
 ZUmDxrPi9C1m3vaNSU0mf8MIi7mdTtvn6NROhsfhMcpxZFA/jkRDPrTOEm19zttIU0AU
 NZ3dTroICJCATwEgaPKsTVZiYtImJpv/d2waFSTBdma5MBM8XSrZSGVyZ5efd77PQvqc
 TlBH8y8PXuiaXnoRjBXv7bOBim/qxs0r8iYGYi7QGVi9hdYLaFr4yxztd70XYxljQf1N
 Y10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107104; x=1793711904;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nMPj2ppS21jLEJLvzVMVJBKb4DfR1yzJLDf3gcwc9pc=;
 b=HB2dCPIlZdZzYCPhKxZqhu+oziMWDSX08IfkDYuqMt4vED/5YETTSp3UO2n3pvmSEX
 +7w82tdfy0eFsMDrhkRdXMh4Tx+L4dH8xAguvY60/WO6PR7tVvtKVOJlxaMN8jOd7R9y
 h/NAZyqUeFq6WQ5GvF4aTOpyXLSKCynmmHLm0O+4xgjZlMM/iXBUPaTBK2MPl49KEqbP
 KCz44hIyr+T3jFMHJuP5zNKFpTJyiqjtWjUTTq6unDgTrnIk8J9bSEC5JhEM3jqzLHZ9
 pFqCOPsFzVCwtJJ5eyVH2x64HTg2EOmbggxdPfotQvIJ3EeeAuVIeFlgOlglVjD+YMlN
 aawA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFXnEkJm1ly5pxgUoBPKZOzouv6iDoRmVu+mSLhR3ZwHO4p+IZxegiyRXS56L6RybUVdxyEOOWpYu2F7Fx@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKqwQwEEhNq2j8m3oV0RuQTQ55JS1dkYV46xta5zSbYWjkksEdQ
 eB4OCz3ohxb6d6wHjPAL5PXMoqyadgsKQ/B55bqjWhHZdyE5JjoEfOAv+7Ou1lK6Tei38L8M2dV
 WZ6i6+aPjHCrcaEoWHnb94D2uJLf0wM3D72ZUX9F5w1rpzvUXOWV3b3X+zUcT80pQsGfU
X-Gm-Gg: AYBFou3dQWT6HbZiyrbFw3+zJyfAVWiBp17S/jBq76Sx6/e3oNbAxIQ7OkJ5BrPNAC6
 dDENqhdcFWxshWe5nbNhTHj6XUOYFb8iJhl8sI0j9xZlM3ZBgjcsZ4BkF6AKYis5+3cn6CmUOTS
 ecLEpoYSSJfXR2gT2m05yIOkLogO3u5Pu/WJH6P/Heb1of5sAXfEHcML9hJ8+lXZ+j8DCIWQS3h
 UWRuo4L9h+vq6eyrBL3IQcSV2u7VVe7RDyRL3LpqXbkNgAVSegqhriBC8fICj+aCuQxPq/9rENt
 qFX/FjGSFhD3Ps5JznjzoBPVLdNNIxIAF6ZdrKKlUJCK8VOrSIuHAn3ZJX0J+8C1jfK5QytoU/8
 HyRnQYzaFVU/ZokruFv3sCOPO+HRaBGm7Ao/EO70IjdQuX09p7pE5LsHJli3LKPnNe5VCGxL+mJ
 w+9Yms+tUuV0yPOs6DybT+BmmRx2CLZxi0yw2eq1rqRVf/U0aFRc5AXYchoNv0JaxCK3l/Cbaef
 pz887WNRzOlg0wEpqyNf4fOddSLsRhThBELYEe9R03+3zSCM45LQC5Yzb7Y4i/I6xE1vo2ao+Zf
 xA0tnrIgNvd3lQv2vf8/KjQmLWxi22AUm4m+bCW7EXQxqxzbbaISx6hYNFDxSmfYZ4MSueplXwR
 vrfGNmlmRsXs6cDK+s+x4jel4HMPgalfAI2aNvdH0BQ==
X-Received: by 2002:a05:600c:4704:b0:4a2:190f:cf6a with SMTP id
 5b1f17b1804b1-4a35acc2ea1mr182042035e9.35.1793107102452; 
 Tue, 27 Oct 2026 06:18:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bae01sm328946425e9.7.2026.10.27.06.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:18:22 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 13:18:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 8599bbe2a80721125ceef7b527c44548eb2c53bf
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 13:18:20 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1c2d7cfffede2d1b1a3cd37615118b3d230465e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xLh4Q-000000006sF-0tpY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2089496750146206025=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2089496750146206025==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="58xM8NQZJTI="; charset=UTF-8

--58xM8NQZJTI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subj=
ect: Add unix-script functionality to the --management feature
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15:

(5 commen=
ts)

File doc/man-sections/management-options=2Erst:

https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852/comment/057f282c_feff05fe?usp=3Demail :
PS15, Li=
ne 142:   :code:`unixscript` this option has no effect since a disconnect w=
ill
> "unixscript" should be "unix-script"=2E
Done


File src/openvpn/init=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/b9187f79_649=
62386?usp=3Demail :
PS15, Line 4388:                      PACKAGE_NAME "_om=
i_%08" PRIx64 "%08" PRIx64 "=2Esock",
> This prints out a 64-bit value so i=
t could theoretically exceed the 8 digits zero-padding=2E [=E2=80=A6]
Chang=
ed it to %016=2E 64 bit are enough here, we don't need 128 bit=2E


File sr=
c/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comm=
ent/51b095c9_66ed99fa?usp=3Demail :
PS15, Line 343: 
> Stray newline added?=

Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/390=
0ef1c_0e74cedf?usp=3Demail :
PS15, Line 2213:             }
> The extra `{}=
` block seems unnecessary=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1852/comment/18656af7_a7e19f71?usp=3Demail :
PS15, Line 3484:          =
       && !openvpn_waitpid_check(man->connection=2Eunix_script_pid, msg_pre=
fix, M_FATAL))
> `openvpn_waitpid_check()` calls `msg(msglevel, "%scould no=
t execute external program (exit code 127) [=E2=80=A6]
Acknowledged



-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436aa782f7e24=
bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 15
Gerrit-Own=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Tue, 27 Oct 2026 13:18:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=


--58xM8NQZJTI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Ch=
ange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/management-opt=
ions=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/057f282c_feff05fe?us=
p=3Demail">Patch Set #15, Line 142:</a> <code style=3D"font-family:monospac=
e,monospace">  :code:`unixscript` this option has no effect since a disconn=
ect will</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">&quot;unixscript&quot; should be &quot;unix-=
script&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1852/comment/b9187f79_64962386?usp=3Demail">Patch Set #15, Line 4388:</=
a> <code style=3D"font-family:monospace,monospace">                     PAC=
KAGE_NAME &quot;_omi_%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Esock&=
quot;,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">This prints out a 64-bit value so it could the=
oretically exceed the 8 digits zero-padding=2E [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Changed it to %016=2E 64 bit are enough here, we don&#39;t need 128 bit=2E=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/51b095c9_66ed99fa?u=
sp=3Demail">Patch Set #15, Line 343:</a> <code style=3D"font-family:monospa=
ce,monospace"></code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">Stray newline added?</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1852/comment/3900ef1c_0e74cedf?usp=3Demail">Patch Set #15, Line 2213:</=
a> <code style=3D"font-family:monospace,monospace">            }</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">The extra `{}` block seems unnecessary=2E</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/com=
ment/18656af7_a7e19f71?usp=3Demail">Patch Set #15, Line 3484:</a> <code sty=
le=3D"font-family:monospace,monospace">                &amp;&amp; !openvpn_=
waitpid_check(man-&gt;connection=2Eunix_script_pid, msg_prefix, M_FATAL))</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">`openvpn_waitpid_check()` calls `msg(msglevel, &quot;%=
scould not execute external program (exit code 127) [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I307e6407=
9f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Tue, 27 Oct 2026 13:18:20 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--58xM8NQZJTI=--


--===============2089496750146206025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2089496750146206025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2089496750146206025==--


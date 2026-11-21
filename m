Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20139606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RtuF1Tbg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ll5WVSfK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Q7Naz5iH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AtC+UdtG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ncYZrMW1wiEV4HUaVHfsXgWsw0BRnjk7FbwGp8vNANs=; b=RtuF1Tbg2kPGfbPCompxvZnw8D
	WQLkEA1TfuSkzF0GmIcVOUbMrC07yhzMbMCmtO90pfOwWatNZEEfjQ7gsDRRerpEUIwolyiA6BJsR
	Wg/QG01xJllOxidzWq81l+m4hv5R8C91fUuaeHVdJvvuByNgpHKdGrd0EEpmFw+JqXKY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUpBz-000000007ki-1baf;
	Sat, 21 Nov 2026 17:48:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUpBy-000000007kM-06XK
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KKJwcbz2PINO+mAn3P9aaC5qo3j64BAJZlDJGXQc+Pc=; b=ll5WVSfKqA3b1lN+T9jVBBiWiY
 /Ny5cheuINSWkQ9l8gh3XWZYRlx5ctHZjuOzvxz08vnCkgj7KUyVaSKCYW39wqlArPtqmmoHnTdPZ
 PHqodaZKQliL6xFcwR+rC1aFXe3QKlb1Wi0qdQIjsurL+0DA3T8xK307FYUckpBJ5mc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KKJwcbz2PINO+mAn3P9aaC5qo3j64BAJZlDJGXQc+Pc=; b=Q7Naz5iHRLetoBmRiB1xu75Rxw
 mCG7k95izmBFf3dKSEDJXEOpwyCG1kJfcW8B6nDao9bvX+NXrZiDOvSSvmUOsGcxHLUKXynJcCC2P
 pr1/wwnyqAm+ymop/PnMRFznSpDgAqElr8jo4o2AIYVtquv35blmR4h2TgoMbiqgyIZI=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUpBx-000000003Wt-1GAV for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:48:01 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-49a92144733so960896f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795283275; x=1795888075; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KKJwcbz2PINO+mAn3P9aaC5qo3j64BAJZlDJGXQc+Pc=;
 b=AtC+UdtGCunw0do7B7VW8S+udJOgd2F0pbOkrEbazs3O2YM24TBBM41EsY/UQ2YhlH
 daOTho9ID35kHr/w6AeWjCu5dacxSDT6KqZKJ8Rlj5GeNpgvr7EZNNxoO2BN++KUHYmF
 v1RYbY41HAv5Nx4SWbUI7SeOB6tS6psN1qy8rQlTzNPSFq0eXjH1FoZ6C3rMunJDjRVe
 8e9fLEQIYFAgnqZl3hdiTbZZMVfNY8SYLzz1fZXj/Fbzeae/hIHUfFy0XWSXEpDYolVF
 sx8np7dBTb4mhJfXdGYWcwb0rkkyoXUiP9hAWtVRUEnh9io7pFMtBAQdIpVxZnfT/r3x
 O99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795283275; x=1795888075;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KKJwcbz2PINO+mAn3P9aaC5qo3j64BAJZlDJGXQc+Pc=;
 b=dKVbAVcknqZzn7li4H/p0Ey+9/HfXnkWjNEEfTZSikyBMjHO7pvdzQVwtVX8nzSTCc
 k3pIU3f6iy5StklK6OTBmZVkdzenH5MYA8V9xW5pKpngNHJeEyofz0sJWzkHWef2mSzO
 QaiL8poO5C/PI9AYu8rno9bBJUmTz8l3/My2wn8DupkgdPobnUnyACJb2vseZtb2Phc+
 YJIGLRcMSWFVLNtZ3MsxEd/QdQq66ROiDKlaWH7NP0zqGqRj61UzFYqulxKLJZZCztOb
 0gcJwMEKcKajWS876QYI7M8U0nB8uoNpMPpV7PNkVMavEephwI9FmEImd3E2yGpCD2PJ
 /XOg==
X-Forwarded-Encrypted: i=1;
 AL+hErEniGu0ESd7DjSqVdula3Aut5LKXU4Soqdupom8ty8kUimbGvTR1skrNYjde6AAT3XbX7miTl/dA0kF1Yh2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+t6nHATErmKOOJ0O8+oVT30jHS7tamlqcrUJkloz5TqudWasln
 yt1VJKkBphIm7wv5wbk1WpQstW1tEvWDSv5uPbxMHTaoy5zVtlsDAYLLRfNXNGcXa+F0S/fV5pK
 yTSWxIp9kQ2aBpZ/PBy8euLS3TgKNDBLb+4EtUn+uCCc2LJEJ0C6Q58V7eSrDyUpMoYjjdCNlJ5
 3ZGqZ5SA==
X-Gm-Gg: AZFdTZeJ2aHlfZm68pmzl46sQ5xnpnqYtpbQ0uwbK97vHoyx2rHMnMjfFBY+Ffay/ZW
 F8AsLw2WXko4uwbTuWnoEpGURJsFbKxS+Yx/pXoLSor9UT/hIaRYZs+UnTLIxuaFvhq7tLH9T5G
 3FFaES+YF2ZpezEKeKQGs+3oPO5W4QjJtpLj8lZAxJL+fmCV+2osBwvvTr20YCr4+WUbBdkT60v
 MU2Gwoj6ps8ltQqKcdERG/5pY4aS8nOq3CU2xlMnpQ6LYFH0C3PgGucV2O/EmuokZSILOp7V9EF
 hLTua1ujhByE+ptTzTDHo8QXsIhkSUIJK6hCNl9R4PACyZjFZnfKevIew0VsU3eFgsws5GjlBJV
 scmAQ9on9800wCw/RJCRioPXC4IzoS2LpFyUa4xZstowol52A9Hp8KhRNyCFBusO/vepBn0tzIg
 hbeYP4Vksqz3xtIaY+fl4owiemjI946iunhcNgZ+kp3WHqMdyWrDPjl8zAYzYWo4E+nOl4fZefr
 j890690KzvKHYb7P0XuQ2l2dDct4swp5uYelUvWaX3GZN/jK3KXc0NDzGVqMx7PAY8mbrUWx8g2
 Ipq0I68tZEg4nVVhAfhKjZ1wPzR21a0SZUB0UYsMxmbjtt9IKg8wSVo4hL4eiSdBizifuWvN092
 JVyn7uzcwW8Eud6XVJPpyrBPedorYbUymgus86TMRq/djk2Ac9+TrLoTg9fEFs2C5FwiR6xsm33
 PtsaUC1j1ZbR0Bkqg=
X-Received: by 2002:adf:e00e:0:10b0:4a7:e4c7:2775 with SMTP id
 ffacd0b85a97d-4abb759e42emr9258138f8f.45.1795283274612; 
 Sat, 21 Nov 2026 09:47:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb42absm13448416f8f.1.2026.11.21.09.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 09:47:54 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 17:47:53 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: a6afe9fa971af9b8e46794cca4f95cfee44e6fa8
X-Gerrit-Comment-Date: Sat, 21 Nov 2026 17:47:53 +0000
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <522b086a77ef1b7fd5c7fdbf5e019187deba6c06-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUpBx-000000003Wt-1GAV
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_freebsd:
 fix route command and return value details
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7928340476331346515=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7928340476331346515==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jIaTyTT9HIg="; charset=UTF-8

--jIaTyTT9HIg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail )

Change=
 subject: networking_freebsd: fix route command and return value details
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2153?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e=
6043178935fdd05e6ea78c411dac5decb7ac64
Gerrit-Change-Number: 2153
Gerrit-Pa=
tchSet: 6
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Sat, 21 Nov 2026 17:47:53 +0000
Gerrit-HasComments: No
=
Gerrit-Has-Labels: Yes

--jIaTyTT9HIg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 6:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=
=3Demail">change 2153</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2153?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2153 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sat, 21 Nov 2026 17:47:53 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--jIaTyTT9HIg=--


--===============7928340476331346515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7928340476331346515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7928340476331346515==--


Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1F606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F10db3Ts;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MtqL0D6w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HAo5mFqz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SBi+WO31
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b7vqzW7o3THk5ofZ/31R8jjIRA76NReYFNc8B97tqGk=; b=F10db3TsoxCWkWWuwOgVl+DGe7
	0ZZaAoavNKt2p0l3Q1J1z9DjBzDbE5n3fpc1Hr5ypKQF69srdY6PW2txZhDeCWsgi/u/tRlM0b3BQ
	TldUD90msXpwuMsIGGpWzk5KA73mFP+RIR4E5JmUQVeACivSt9UmIBtQPGkYwwl3bQz0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStMk-000000003D1-00Zo;
	Mon, 16 Nov 2026 09:51:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xStMi-000000003Co-2VGx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qUvS2RDsh9eHFuFb6NJhv0LE695Ks6zFlvCjzzXAUTQ=; b=MtqL0D6wAwDoveoxA5cWCO16qe
 VG5DGEU3Wsfz+bvcT/Rq8lOv9Xjklq/Y+BIbezPMkSKQ8XRWpmccOm5EfdI4IQiqvcpA/NhMgqMf0
 wjbhTP91/GpCsz3NnysjamyNZU5FsgiXNOPOGfoF1JGG1kKRzrMaaSD3po7E4dulXKkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qUvS2RDsh9eHFuFb6NJhv0LE695Ks6zFlvCjzzXAUTQ=; b=HAo5mFqz6gG//gnJKhLCjotkm8
 H1/bo84Nz/OSmk2xQNuURzX63RRIao1TYiQoSI9iDNAcmHveyInqp+i/KHzCWAp0XVxwkJ+pw4MJ2
 dpSG1osaVabAEIax0QWjpERr+lk2+MUF4BIKlNDREsV+x2neOyVHsq8bpMDZyWVzEADo=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xStMg-000000002Gf-3Yn8 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:51:08 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so7228475e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794822660; x=1795427460; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qUvS2RDsh9eHFuFb6NJhv0LE695Ks6zFlvCjzzXAUTQ=;
 b=SBi+WO3183wvzsQAAX1R+ohCZfwNxtpNzk6t5QnRlKt/LXoBrenpGCR0ZFl7LsEoLv
 Cy5+o/obUEWivAAtUriJyKxlJx+FbEp61N241BJWdrRYXcdQ7XuNGuPpt7b4u4kd9APz
 XOOvz3cEZjph4KG2eYJGxpkFyhLzk7ttg+YL5c0mDakFk4jRoNSD4bqOVHr4PoUccpo4
 O6wHv4yyBisiNN7Va5BEyPt8CvtBT7mGdUfr3bnMM9BYuRaqfgg8NQjOY2H/r2dGNTmt
 K1mVnsI5eKytpL5sKSrGGr3CPVhU/00zsZcX8Bt4aL6Yvz9icwzHgTS295l6Demq8nbp
 QjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794822660; x=1795427460;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qUvS2RDsh9eHFuFb6NJhv0LE695Ks6zFlvCjzzXAUTQ=;
 b=xyRZPF6EDRaoiIu9xxVAJwINYEG66aNwAxcZhRCTKxhZFzYAA0zpEM+NdYMQx5vBeI
 XPoj+Lzc/ja8bDkjFeuu2uDrXWNwC2ZPQIZqD+IwSSHePaJi6+ahrdB13CdMlasQizx0
 zq2vE22jZ3E1bvcbgDydocZuqwzt/P3aH5aTtPlv/l7bwbCA5JsGwRpA691hVXDWnJF0
 GRvCKhPbm/qdz71ZpsOihgWYbg8bxVemD/s6ckOz5fey2Md2sNPQE0knVo0p8MdOQKDR
 lL7ajt8VFmOZ+uozqNiPm/yA4ftuy7BLuePkEkcc8USyWBbNApp+fkAE1qy5WJpJyVlR
 zhxw==
X-Gm-Message-State: APuU4Z86eb56lOgy6S7NLudJApNoxWsmwdhnyjXG4pD+K3eHkf21ZCs5
 ujFED86+83FgXSNHX6x9f7FRH0uDcMVsrbId77Zl5Nc1WVS8p+fGFSMM48aE0wLYJYYk5m+OsBr
 /xZVDqePZbN1SPoaaWRnergRv7f1RFp4JooVle64r+A71Rh3BDm1Htb2jXIwbzDoAr5Ii
X-Gm-Gg: AYBFou33jCExn4M5ZHip03G8HME8QUOg8139TDQDsRB2Q25BRqZ6lUYLCHnnktRs6kl
 tUPzfgqPx4AARzethB/Ssk1j7fA32Uh2n7hnk3mDAy2NYrmBxRorDxm/EAsx0IbFblNShcGZR4x
 zK9s+IBmZKLDNZ+w4nb+kUvzpHmO1Z9fMlHAPKkHHw5J4LGKZlM8EUmhPAaW7BOG5X5/zqL8dIe
 C4fanH8ju26u6rbosx09VTXsPoN2AoTJhsa8DcVERfRr80jpmhCe1E+9/gjy5OsosOdZOqCJFAN
 MKvzXO4MPr8AnP27xDzGtduuZfCLtjuLi5/Imudt12r1ngEjcZ9qRyRNHcm8Ii3tykOrEoqNaGD
 yT+oJu9XouqqIyOjOzj086CB7bTrTz/9+UGSK0ub5mHbLV5qEsThJc/fnl4JYAQC4jy8dxWDHOt
 J4M+jIqHlx4VLtc1XoPQL/D+dneaWP6oXCZHFTRoKeFokcLg7Az0ZsZo0Hl9rey3pZwJvKzvI5q
 MdOsw3y/SlwjHCGLxCrSUfIz5jxaH4bw96cDQ02b8cQD0QiduzhRCSCf7iMmo+jDkD1y+gxwSSD
 9zyzpmDSwr9neuBNKEIf2uWnha5lXittQvSZtIPkMPVnjFtzApmAen1Yztvtxbd9Ex8b3qRkRtE
 FvpWrRD10JcPMnjlurRNxj51rZbu/j4yjkBYLkQJqMwxZXXIKQjG4GhUGe78kr48SbtnbpkLky0
 jqDZcbCCljOmj/v0o=
X-Received: by 2002:a05:600c:4e88:b0:4bb:6f41:399f with SMTP id
 5b1f17b1804b1-4bb6f413a83mr69640785e9.24.1794822659949; 
 Mon, 16 Nov 2026 01:50:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5faf05f8sm161889345e9.10.2026.11.16.01.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:50:59 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:50:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I793327150883ea0207bcb9724341e750bab92474
X-Gerrit-Change-Number: 2179
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2179?usp=email>
X-Gerrit-Commit: b94220584e03a56507d568c6030e31b360322cfe
In-Reply-To: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
References: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2Njg3MDAwLkk3OTMzMjcxNTA4ODNlYTAyMDdiY2I5NzI0MzQxZTc1MGJhYjkyNDc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5232ca3bbf45bb6cd5d8d23bfaa7ec1d8fb30711-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xStMg-000000002Gf-3Yn8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: wipe and
 free partial responses on conversation failure
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0514949880259518701=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0514949880259518701==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r/iGn/UbrUM="; charset=UTF-8

--r/iGn/UbrUM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2179?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: auth-pam: wipe and f=
ree partial responses on conversation failure
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

auth-pam: wipe and free partial response=
s on conversation failure

When a later message failed, my_conv() freed the=
 response array but
not the responses already filled in, leaking copies of =
the password,
username or OTP without wiping them=2E

Change-Id: I793327150=
883ea0207bcb9724341e750bab92474
Signed-off-by: Razvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179
Message-Id: <20261112141=
839=2E5147-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg41194=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/plugins/auth-pam/auth-pam=2Ec=

1 file changed, 8 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/2179/2

diff --git a/src/plu=
gins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 72c047=
d=2E=2E16fd2a1 100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/plu=
gins/auth-pam/auth-pam=2Ec
@@ -789,6 +789,14 @@
     }
     else
     {
+  =
      for (int i =3D 0; i < num_msg; ++i)
+        {
+            if (aresp=
[i]=2Eresp)
+            {
+                plugin_secure_memzero(aresp[i]=
=2Eresp, strlen(aresp[i]=2Eresp));
+                free(aresp[i]=2Eresp);
=
+            }
+        }
         free(aresp);
     }
 

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I793327150883ea0207bcb9724341e750=
bab92474
Gerrit-Change-Number: 2179
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--r/iGn/UbrUM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2179?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">auth-pam: wipe and free partial responses on conversation failure<br><b=
r>When a later message failed, my_conv() freed the response array but<br>no=
t the responses already filled in, leaking copies of the password,<br>usern=
ame or OTP without wiping them=2E<br><br>Change-Id: I793327150883ea0207bcb9=
724341e750bab92474<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179<br>Message-Id: &=
lt;20261112141839=2E5147-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41194=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/plugins/auth-pam/auth-pam=2Ec<br>1 file changed, 8 insertions(+), 0 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/79/2179/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/plugins/au=
th-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>ind=
ex 72c047d=2E=2E16fd2a1 100644</span><br><span>--- a/src/plugins/auth-pam/a=
uth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/auth-pam=2Ec</span><=
br><span>@@ -789,6 +789,14 @@</span><br><span>     }</span><br><span>     e=
lse</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (int i =3D 0; i &lt; num_msg; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (aresp[i]=2Eresp)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                plugin_secure_memzero(aresp[=
i]=2Eresp, strlen(aresp[i]=2Eresp));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                free(aresp[i]=2Eresp);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span>         free(aresp=
);</span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail">change 2179</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7933=
27150883ea0207bcb9724341e750bab92474 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2179 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--r/iGn/UbrUM=--


--===============0514949880259518701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0514949880259518701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0514949880259518701==--


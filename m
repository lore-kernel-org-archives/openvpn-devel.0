Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12F606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K4vEE5nb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dZwDAXbV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ap7ZYC28;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HklPx+km
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=omu4+1jHtsAGkYH/OKnlEj82ik9z829fYDnUInj6IBc=; b=K4vEE5nbnnfhg5xtakI/4NmVqU
	2SipRVPX34A59tcAkAngo5B0accCdI79OFlxBi/6WrmkEuL9HPGdu+0+ivOcabLLUSzieKy7NbGHJ
	aTbxjp3C/YCoTxXkL9eDQGfG5Llj8VnvpnEpyPuejF5K2OWIUEXRm01TjkHYQkeYJI/g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOWVj-000000006t5-3diu;
	Wed, 04 Nov 2026 08:38:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOWVB-000000006rM-1Xgo
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=udGvvQPM0H7mTL/h/GwlFOj/LQDoI1JtwbI7Ty6co6E=; b=dZwDAXbVcwecJh8jp2kEWgEpmq
 sFXVy7vVjpCg28LsJYswXyzOeB/kPoHVvDB+sM45zt7Tauni0RvWjy0bmVsmy14ljiNv7oDAHJnOb
 HV7wN+3vAAL+4EiCS706dIftaMPEUICReGpg/5akBLa3QT3DYMfREwdsgJ88gjU1yCR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=udGvvQPM0H7mTL/h/GwlFOj/LQDoI1JtwbI7Ty6co6E=; b=ap7ZYC28hNXwS205KYzYx80mEu
 TUjrkoHL8m2L5V2KKYPlWWZ2PATvFtxB8xHPBNbC1iyqaWbN3bQPLsV4g5iAb7XCtq92ShxNd2icL
 DGIwKW5z2McLBa5u3L2yHp79DBh08RpqCsM7u6RYVD2XijiXW7KVMNQbZRAB7xJ4rUeI=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOWUY-000000002jk-3drx for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:37:49 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so3100835e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 00:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793781424; x=1794386224; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=udGvvQPM0H7mTL/h/GwlFOj/LQDoI1JtwbI7Ty6co6E=;
 b=HklPx+kmJfJ0rjHKXsxizW/D7hOFJyKHwcN9VXJU2WFUSL8CvTxPFUHwWSzPubBDFO
 Psab3jrWirM27w6cMnXNDm1mF5hXId8w/i53wTyNtdStFo5kYtbLOeUSAts3eymE9N6Y
 c9Gsm6E18OgqEpkrJPPxGOfx9xc39aIoEJg3PrHKW1l5Pj1CcCDDyR37iHdXOO5RX4QX
 Jm08Ha9CqN3J1x8a5eAQNimRHMFlCUwAJ58HxgL3YOLpg5TihBgyQ3ZKzl3as/1Qegvu
 5QlfX34x5SwnMlJbj/rgLCZPHLe8z1wq2mTYTXaHcnpAjAb7v9bcYZcpZpJXlwz+Puvi
 ovfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793781424; x=1794386224;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=udGvvQPM0H7mTL/h/GwlFOj/LQDoI1JtwbI7Ty6co6E=;
 b=C03DQrClRpEu+QADodjO+yNMr/v02A/g2KSXFZxgy8YThri4JgL0mmzdAFMK5HOJdT
 D+94qwIaCNKVefiEUx3HahvXGcSWC9iZ1vr1ntWY1iFEIFR7Q8RTOuP26ho+qIrseU0S
 BWZAUrPAPavAywbmRo9AzJFE6koWHN7AqZTj7NUKXAzRorNu/TppqaINPtJ3zM1qjghC
 GM4w9BO63g+tm8Nh4UNxOkcVM74BZTzApj+mN1UCEAoKaOoMjOW7Xmma3yAfh6PV3w75
 cOIQXhY0x18b4wUgzntcl8YWT1tMKjmkx+kGi9vI9I1w2oxjGKJ4hhuDlD9mOmOO4g2S
 NWTA==
X-Gm-Message-State: APuU4Z8H/n8aSJjf9m/ZuUfRtBnQAI6/G715LgKCMdRq1cTZrszZdkm2
 z02Zh9xFRz3+0zT8SC3rS6t76bW3k22mu45iuvqcP6qRbVdT2qcTh3VTN8rh26TtTL4Fn1xN4WP
 6iK+rVDUztscxOpf41FySNQSJyLt0DNUQrv3YSb5sJqp80hVXdW5CmnQPbVUEN0R8gH5dzM3Pwx
 shNcC9cA==
X-Gm-Gg: AYBFou3JJ4ttt08FdfNi9CpixMJ0VdaSt5+GW52MixUWL9jf/wLt0/ZIEkHfxsi3Jyv
 w+4EwyLKggz0oXwGsu6+8rTXxvK00GpCe8AAWoD0P6IQtKc6YMqKSJt3SdbHIjzJrVh7urQZHP9
 s31ezitvdjR2cr8Sx2l+HRi+n8aWMLhvGj0GlN+O/zsyhEuzbzFMzYMQz+YfxMtwJ53tmeNqEij
 aZfT03Eu2M7dMOMYILVu23C9MDJHIe/zU2udoNNKndXxGZhCsWMh8r6Rd8igTNU5WamP3dp20Z5
 DTEW9A/KclmedOpyzD+NbIaedkPSEMmqsFZgbxITpRdDnfmpC48WB+zOit63hMWQP+JP2ENUEIF
 EpKuP+pWv4lq88BTlYKoFozhrycj0aehqsdJJGK2SVx/iBi81wfHAc5MlQtwz+2sdTw8d2uWgkJ
 UGhHjTPV5bajkYqbVjRP0NL0DCmdB3V+z53UTyZAcJAVdeLEvNptQNMCi09zbOxQm5EbhylmnoM
 PlUFadrSdwIvj83zNgGNlTwuuxyUTunat6qhyfJQc5t7S1UqmQX9+RYVlJH0qKiVUpQ/SuAllQ+
 eJYT/NBxB2siry/QSbdKkG/kfJ3uGFJs14VrTNxb2erINMJ+kQK2WqCvzRSiZzyvA+WIpYdg/HY
 XezbLtgcVX3TktcM2+i83Cirj7kkqmYX4sr3iCJrjfmJGRJXXomV2EsniMF9CkjIkEFOBIvx1+M
 T7b2y86pNfHRBgww==
X-Received: by 2002:a05:600c:524b:b0:4b2:612d:908c with SMTP id
 5b1f17b1804b1-4b2612d90d4mr126166335e9.34.1793781424133; 
 Wed, 04 Nov 2026 00:37:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4532916f2sm33868085e9.5.2026.11.04.00.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:37:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 08:37:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd
X-Gerrit-Change-Number: 2127
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2127?usp=email>
X-Gerrit-Commit: c713ad00acf2c3fa70dc51c9281ba60ea9d3fc6c
References: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxNDIyMDAwLkkyZDY3N2VlYjZhZTkxODZlZGUyYWViM2MyZTBjMTJkMjVjOTM1ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c549e2f4c98e1b41be9169805c5a35949d4be263-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOWUY-000000002jk-3drx
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: return NULL
 when the second adapter info query fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8207995438939308253=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8207995438939308253==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A6ND0lyTJ5c="; charset=UTF-8

--A6ND0lyTJ5c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2127?usp=3Demail

to review the following change=2E
=


Change subject: tun: return NULL when the second adapter info query fails=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: retur=
n NULL when the second adapter info query fails

get_per_adapter_info() and=
 get_interface_info_list() returned the
allocated but unfilled buffer when =
the second GetPerAdapterInfo() or
GetInterfaceInfo() call failed, so caller=
s read uninitialized data=2E
Return NULL, as get_adapter_info_list() alread=
y does=2E All callers
check for it=2E

Change-Id: I2d677eeb6ae9186ede2aeb3c=
2e0c12d25c935fcd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---=

M src/openvpn/tun=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)



 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/2127/1=


diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 225d8b1=2E=
=2E7637dc0 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -4=
129,6 +4129,7 @@
             {
                 msg(M_INFO, "GetPerAdapter=
Info #2 failed (status=3D%lu) : %s", status,
                     strerror_=
win32(status, gc));
+                pi =3D NULL;
             }
         }=

     }
@@ -4158,6 +4159,7 @@
         {
             msg(M_INFO, "GetInter=
faceInfo #2 failed (status=3D%lu) : %s", status,
                 strerror_=
win32(status, gc));
+            ii =3D NULL;
         }
     }
     return=
 ii;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d677eeb6ae=
9186ede2aeb3c2e0c12d25c935fcd
Gerrit-Change-Number: 2127
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>

--A6ND0lyTJ5c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tun: return NULL when the second adapter info query fai=
ls<br><br>get_per_adapter_info() and get_interface_info_list() returned the=
<br>allocated but unfilled buffer when the second GetPerAdapterInfo() or<br=
>GetInterfaceInfo() call failed, so callers read uninitialized data=2E<br>R=
eturn NULL, as get_adapter_info_list() already does=2E All callers<br>check=
 for it=2E<br><br>Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src=
/openvpn/tun=2Ec<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/27/2127/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/=
tun=2Ec</span><br><span>index 225d8b1=2E=2E7637dc0 100644</span><br><span>-=
-- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><b=
r><span>@@ -4129,6 +4129,7 @@</span><br><span>             {</span><br><spa=
n>                 msg(M_INFO, &quot;GetPerAdapterInfo #2 failed (status=3D=
%lu) : %s&quot;, status,</span><br><span>                     strerror_win3=
2(status, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            pi =3D NULL;</span><br><span>             }</span><br><span>   =
      }</span><br><span>     }</span><br><span>@@ -4158,6 +4159,7 @@</span>=
<br><span>         {</span><br><span>             msg(M_INFO, &quot;GetInte=
rfaceInfo #2 failed (status=3D%lu) : %s&quot;, status,</span><br><span>    =
             strerror_win32(status, gc));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            ii =3D NULL;</span><br><span>         }</=
span><br><span>     }</span><br><span>     return ii;</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2127?usp=
=3Demail">change 2127</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2127?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2127 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--A6ND0lyTJ5c=--


--===============8207995438939308253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8207995438939308253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8207995438939308253==--


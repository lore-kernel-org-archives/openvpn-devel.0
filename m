Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AB0C9833F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=suU/9vDnVYxvJd+u1rbigUKa2IZD6uRK2xjNRFVDYzA=; b=iL4HtTJSoRY9HLoriIfklmY8Lf
	qvWtT7d9dM+JTl8K3AfujyNATpTY3aRmkLhhSlFHkYNKRZkV4q30nttG9CruU+1V8dAm6nYr4rjT+
	COZZhu6YW8vw4CwxyjIk2zxZ68ZPEDKfn+0L6k0RqVlRus86Sj+6I436PH/no0N9Wrpk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBBX8-0000ER-JP;
	Mon, 28 Sep 2026 13:36:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBBX7-0000EL-RH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 13:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=z1g/RqF+HFB3kBV06PnMc31uH5rScbg7mytTOx0klDU=; b=SpmJM9FBNS9FGKpKylqilk1X0v
 id7qBrOgiVyyO3jng+ymrm8X/3v4WZDsnK55S/xBX8SX+0ry5lPKNmqkF/ILZHKkVuLQ1gzN7iuIm
 CTr7v2xAMeWVCi5zECPNqMQyEBsRo1ZflcEWpAzOzd7VokU4phi6dsqXzI0JB5pbYYQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z1g/RqF+HFB3kBV06PnMc31uH5rScbg7mytTOx0klDU=; b=M
 CzcwqG+r5/Kl56VcczhUgY/kakBvyHsmifR9PTgM6VpTaxfPDsc3p3C8R53Qi5pg1DY+gwN92wrLl
 9xLMfFUfyQhUejom+j57l30w86m1vwvt/MsJjuqWGCOy+1bISt1NCCSSp/FF0VCXGXXuHcrwFm+0O
 9qZ00bV/kvQYE+U8=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBBX6-0005ix-19 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 13:36:41 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48870973bddso1371492f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790602593; x=1791207393; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z1g/RqF+HFB3kBV06PnMc31uH5rScbg7mytTOx0klDU=;
 b=QuLd2EX3JJRnCy8+F5LDDvC4Cw9uXr0GwBTG2Bh5zBbqQRZKHlEuOUoYzAZcTFD/y7
 8C0obfu++uK4WF8ioCawerRKpveTL20aOaKoloopKhF5TzvBevjuRabFDSjEPM7PZiEi
 hMJL4P0BEJPZd9nM/U5wNienyrie4Vbddu6vvfEuliUsYzv4fgjfTQenHvj9XjU+cRZp
 rm1+oPxTCIWP9rLLjSmRB42SotTbZAGwOIVvYlfBoX4AwXTsL1YrwczHIjoxxKuXvmvh
 Qz/G/kFFsuucz6nlrSFW4uOGhmM5nOUfGxrAI5GOLf+EZIV6bp07JNC0+1pdM/xSLPqY
 TNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602593; x=1791207393;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z1g/RqF+HFB3kBV06PnMc31uH5rScbg7mytTOx0klDU=;
 b=o9aFcw8ZgGrZfXTYuGH2tCDH/sRdvb6y7EAwh0ovBZdOHz5KeRZUY8mdLxAwCIr8d/
 KvNqO6XJLwYyai6HEPyyWm7j5c9jh97LL8XQtzSyNWNa7IYeqYu7CHO/+3kHppHJ/COy
 VVcTKtvFwwNZ5G6gh6lKGDwVuhX91zcwntvG88YwdzwOcSCAGSvcSLQVfj8OJyIv+SEP
 bYdzbKQI0+j+6UIjRMS0QGmQst7h8Kjz2vRa9Wa0WbCK3T7pyFtFHmY3KquouHIv0Mcj
 xIL9kEzdeKnmMYdKSyqp1Bw4Rd7DmHY3SWYYxD+P24Z5T7z/ZaUdUNleCBd3pDltBJut
 jv5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByGqdYcj+CnO9857fe33tA4gp1zv1+juEKsXlQu1EpnGD0j5K78UFz7lqqMOdL1tSCSNx8h3/RySlDx8lnw@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKoL6JC3tyGXcvJ1MOSzONZYpHsbn0yoNBjcRcjFcJWrITsB4iM
 2SViBPSgSUBaFKq0eyzns7eJTLm2qbtzpxCxIHVvOEWNJvSQ9cjSkd20AE06uMS8YjGfNqowIJd
 Xfb5YBmJe8/y7hlEDSxr+mGHnY3wesOpBYzrJb4Zek1srh2N9WYpAVqrtcdsLiTl4961x
X-Gm-Gg: AYBFou0mcBUA/IyBm7Uv8I0u9FE7SVPDfv5DC+ozu3Mtfi7yGTRhYA8pZGoXyjZTqBV
 BlfwmBGUW6W7vUrbXt2yaAOFMA9RADpDBqV5ILeDbxnG1kqJRUoiXy9NAzDMHKpL5gnBjdR3Ts7
 QaQ184FS6gmJS6KPlRtbhM7KPSsKkybRNEQeDrmJegx4B55kklb3WK9Czw+WNQiJWH3dyfr11qK
 O/zH4+uwwm9xWhAcTVkBM1Zcrp5iYnT9gslowMqu6QiLLBitu5P59l9L9oZfYfkSerpYUf9i1ug
 PoUI0Q1C29KLzP0BedZcWbpR6QeZz+jDM7paiTYdYvF5KfXRntIlZGQ5Xu5TzluqexkeiwU+FUa
 /BdEg8uOml6iJdGk7Sk6o/BQej+O+1ebB1pksQmtl4xiXp4uVuzVQCEzU+iit5rVRKBLBaXf/nC
 w3WtZDtyqFcyDpCP0zM6nrciTfMYqhdZ6FyHkKR8MYi8y514mFlimknM00LlS+cF9fzC9gJEQSJ
 LVkvc2B/XQpa7DkbZecuHXIzO5qHEE1VQFJhi+JYUg6s1mZsQYm/JzQF8mBBVxynRVrPkySTLaj
 SldtptrIummpZxPIabxTMGuu0CL3a8sEZDpEMVdSnGU7HtU6tiO3GNA8Lcll
X-Received: by 2002:a05:6000:4103:b0:487:c3e:d6cc with SMTP id
 ffacd0b85a97d-4887171e51bmr23722751f8f.31.1790602593052; 
 Mon, 28 Sep 2026 06:36:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48aecf40a8dsm2806967f8f.18.2026.09.28.06.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:36:32 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 13:36:29 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 5021b5a573c2cf4d791c625689bd920c94916de3
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 13:36:29 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d7185d777516cae1e22fdbe265ac00c795678ce-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBBX6-0005ix-19
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3809181413556856677=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3809181413556856677==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dSbmZTwLW7Q="; charset=UTF-8

--dSbmZTwLW7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Win=
dows 10 API and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Fil=
e src/openvpn/win32=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/co=
mment/2e586562_54ee6de4?usp=3Demail :
PS1, Line 1350:     if (is_wow64)
Thi=
s is I believe a bug=2E

This patch doesn't introduce it, but after staring=
 at the code for a bit, reading the Microsoft docs at https://learn=2Emicro=
soft=2Ecom/en-us/windows/win32/api/wow64apiset/nf-wow64apiset-iswow64proces=
s2 and doing more research it looks like the `BOOL` returned by `IsWow64Pro=
cess2()` only tells us if the function suceeded or failed=2E

It can fail f=
or reasons such as `ERROR_ACCESS_DENIED`, `ERROR_INVALID_HANDLE` or `ERROR_=
INVALID_PARAMETER`, and if it succeds it doesn't mean the process `is_wow64=
` really=2E


We may want something like this:

```
    USHORT process_mach=
ine =3D 0;
    USHORT native_machine =3D 0;
    if (!IsWow64Process2(GetCur=
rentProcess(), &process_machine, &native_machine))
    {
        return;
  =
  }

    switch (native_machine)
    {
        case IMAGE_FILE_MACHINE_ARM6=
4:
            *host_arch =3D ARCH_ARM64;
            break;

        case =
IMAGE_FILE_MACHINE_AMD64:
            *host_arch =3D ARCH_AMD64;
          =
  break;

        case IMAGE_FILE_MACHINE_I386:
            *host_arch =3D =
ARCH_X86;
            break;

        default:
            *host_arch =3D A=
RCH_UNKNOWN;
            break;
    }

    if (*host_arch =3D=3D *process_a=
rch)
    {
        *host_arch =3D ARCH_NATIVE;
    }
```



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8=
a79a
Gerrit-Change-Number: 1955
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Mon, 28 Sep 2026 13:36:29 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No

--dSbmZTwLW7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/win32=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
955/comment/2e586562_54ee6de4?usp=3Demail">Patch Set #1, Line 1350:</a> <co=
de style=3D"font-family:monospace,monospace">    if (is_wow64)</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
his is I believe a bug=2E</p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">This patch doesn&#39;t introduce it, but afte=
r staring at the code for a bit, reading the Microsoft docs at https://lear=
n=2Emicrosoft=2Ecom/en-us/windows/win32/api/wow64apiset/nf-wow64apiset-iswo=
w64process2 and doing more research it looks like the `BOOL` returned by `I=
sWow64Process2()` only tells us if the function suceeded or failed=2E</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I=
t can fail for reasons such as `ERROR_ACCESS_DENIED`, `ERROR_INVALID_HANDLE=
` or `ERROR_INVALID_PARAMETER`, and if it succeds it doesn&#39;t mean the p=
rocess `is_wow64` really=2E</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;"><br>We may want something like this:</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">```<br>    USHORT process_machine =3D 0;<br>    USHORT native_ma=
chine =3D 0;<br>    if (!IsWow64Process2(GetCurrentProcess(), &amp;process_=
machine, &amp;native_machine))<br>    {<br>        return;<br>    }</pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">    switch (native_machine)<br>    {<br>        case IMAGE_FILE=
_MACHINE_ARM64:<br>            *host_arch =3D ARCH_ARM64;<br>            br=
eak;</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">        case IMAGE_FILE_MACHINE_AMD64:<br>         =
   *host_arch =3D ARCH_AMD64;<br>            break;</pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">    =
    case IMAGE_FILE_MACHINE_I386:<br>            *host_arch =3D ARCH_X86;<b=
r>            break;</pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">        default:<br>            *ho=
st_arch =3D ARCH_UNKNOWN;<br>            break;<br>    }</pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>    if (*host_arch =3D=3D *process_arch)<br>    {<br>        *host_arch =
=3D ARCH_NATIVE;<br>    }<br>```</pre></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">cha=
nge 1955</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1955 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 28 Sep 2026 1=
3:36:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></h=
tml>
--dSbmZTwLW7Q=--


--===============3809181413556856677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3809181413556856677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3809181413556856677==--


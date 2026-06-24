Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E63ECDB479
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XTrYWvSkrEu64mWd+ehkzYvv3PiBE1maEf+wYSf/c44=; b=K0OfPLZZID8Ar9VnH7TlEdRzG+
	YlTeugkNeyFPGiH1oT2QsVITpbCvlqXquZ4DfSR5TQEnyP6dk3NWeSpeBDSZAbAU6c4UOYMsdzXwp
	bQrJnwjkdnLhRTkloVhZ97ECmtBdBsLA1GlS4l1T+u2Z9ZZTCnpgTooZIKjlI0VGy2x8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcOZ8-0003cg-CC;
	Wed, 24 Jun 2026 14:26:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wcOYn-0003c7-Ve
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S0az/jC8z5nOmWXZfdNii8hZ8Gy7LeEifyOEBWoKTtw=; b=PbZ2zFbEjoOJa7O9QPIPdsSs/b
 91J7FeVIw4s5P5q8o+IbgeSU0rKMZ/BvmnbWCoa7sxS5rexwnX9VPqSIXfsCUt81n/zT9xbm1aPwH
 2HxrBHNl03XBMpk6H+igB+CiVHr5HTtUrGN97ciBApvzsrB3v9UOYPkO1ZaocLRsIxxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S0az/jC8z5nOmWXZfdNii8hZ8Gy7LeEifyOEBWoKTtw=; b=W
 K7NUKARliDdWSPaj8e1aZwBpCObwZuhfEnJUDx3cHbJZeg780UkdS4DwcPbUqfMta7OEa+YNIQdfb
 RlZaiwCbKcWI/hxhR4I33twI7cHNO/UdjXNv07IsXm1cx6qrSL0OAV7GcpvQcJKidpJEqo+D1k6Kx
 jmJYjtiZ/jUUt+pk=;
Received: from mail-vk1-f171.google.com ([209.85.221.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcOYb-0008A7-Gl for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:26:27 +0000
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-59e2b96e3d3so823788e0c.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1782311180; x=1782915980; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=S0az/jC8z5nOmWXZfdNii8hZ8Gy7LeEifyOEBWoKTtw=;
 b=Pvp91vWOFqEbnWONXXhUw/uWi4BiryMig5WIfA6H5QWle5+CtZ6mNI6XdZni1m/BqD
 vMr8WEYy0wFrYwJrYgIVD6iG1lVRQbz3M1JcifNfzPqIxVwz/jOBT4K/Ul1p3W5LXV+i
 TJG7iOIh7OxGraBuybd312agRZKNSlyHczLOTMIlpuMn2gdk1sLprz5+qUPzOadQTilM
 VyRezzROzugsSqgx92QGS1iFMHTCOl0GOtOtMVsN5y2fXCQIajh/gzVOdhILLdmBtouc
 cDlPEb0dIrw4VEH0PVBCIJsPH0O0LKoRe9rSWopA/KhB/wWhb090F/YgdZ6b7Nt33OQ8
 HbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311180; x=1782915980;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0az/jC8z5nOmWXZfdNii8hZ8Gy7LeEifyOEBWoKTtw=;
 b=PMqZIsDbp0nhG3xgm1WVE0JMAJ354/WTojzQy1TG0FoRrLfbAPyU6hgDQp/iIygkuW
 sPsUmn46oYc5rviD0ZS0hmkJ1qfO2DPg/PDEiJscn6KTJNgLS90U1xrZrO4W8MvQHPMI
 xZAvlqdtU3sZDutgD+1VT+k1G6lwg7ISHkgajq1y3xiTLxb6Kd+cD6iQsSnh+70hDOxb
 HyyhZMY9mrXlRzFcuNoa81E4WISnMeOzMOyNqhfaK5DNBtPP2PHpTi/tcG7qj0vWZqxp
 oBD5d+6tyDLGPThPS3W0HxYc6OWeylyZ8t8oNeRDPrzx6iZ0IZhj7Zju+A/m3iekgTZy
 y6nA==
X-Gm-Message-State: AOJu0Yxqqh4LwYul8v0lkSTD3sF9FcrdhKNkuJCqfde01aMsqEfagT3A
 VTOdtF1SfTIEkoHpMQovh4qHm3Xr0IVR1w/1W4lpPZGSUBXcLXjODugfsZVSYwEeMrMzpyGQTKq
 3djRikmx1oVCu4Ssdi2d0Ng+F47zFtBhZxrbypCOi4I/oQfKbt80zsB4d+MkHHB4XoHmbTLHLAO
 E7VwBHXQ==
X-Gm-Gg: AfdE7cmJ2rZ8I+v8O5O+fBlD7gPEYhsCOH6RuIVZvBHfyl7DV2xaE3ecJVmcdBTVEGW
 EZhJD1ZWyRF+P58UJVy1Y5Nny+6KFqu0CtIZmJ1bxvi0ye8so5g1dJXrJEpbzstAg6oigXkVc7a
 YA+9bGdkUsZ2R3ImSw8s3Vb5MByfLcfR1q4/06d8Nq0k+x+s4i9PBRSA7MxTz/lwo3nXeu3PEou
 Ty1KGPAINUUx1x7Oo0x1yNsFqNN9aV5pGgphb/U+2/qFgxGPUVP0vqRIaOxpV4ylaaipF5h7GXD
 EB1n4UgRcv5h/qSHGkfMxWaVWzqyhP9PJZ2hOffNGVQRrDAIaP1AO3hzQDHKw7nAjTyjeXiRBH1
 oeITiUkAZZbBPagemgEatQWSMrRn4c/W7sq1yrGIFmGD0egDyqpJ5klzKYPgrLaGlcfP+Wg34Ds
 kPfqmo5EfPl+b7m0znVws1l4/XzotHRLd0zhLc/Tckdk8TucdEQx8kBXA7rA==
X-Received: by 2002:a05:6a00:4193:b0:845:43d6:14d7 with SMTP id
 d2e1a72fcca58-845a2abde38mr4442222b3a.16.1782304881392; 
 Wed, 24 Jun 2026 05:41:21 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:1bd4:4911:62f1:c1f6?
 ([2001:ee0:4f83:3c70:1bd4:4911:62f1:c1f6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a4121fdbsm2170367b3a.51.2026.06.24.05.41.20
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 05:41:20 -0700 (PDT)
Message-ID: <140c97f6-2f9f-451a-9f0d-44f0d7b2f1c6@openvpn.com>
Date: Wed, 24 Jun 2026 19:41:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wcOYb-0008A7-Gl
Subject: [Openvpn-devel]  IRC community meeting summary
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
From: Johan Draaisma via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Johan Draaisma <johan@openvpn.com>
Content-Type: multipart/mixed; boundary="===============2182555962473104899=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============2182555962473104899==
Content-Type: multipart/alternative;
 boundary="------------usgNIrcp06FiS2tpOom8eCi0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------usgNIrcp06FiS2tpOom8eCi0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 24 June 2026:

  *

    *Updated: openvpn releases*
    Currently we're handling a number of reported issues, some security
    related.
    The openvpn release 2.6.21 and 2.7.5 estimated release date is
    currently still July 1st.
    Some important fixes will be backported to the 2.5 branch but since
    those are out of support there will be official 2.5.x release.

  *

    *Updated: ordex suggested to bring patchwork back*
    This is now up and running. This will be used as just an additional
    tool.

  *

    *New: test latency and MTU in openvpn*
    A new feature is proposed for adding to master; ability to do
    latency and MTU tests in the OpenVPN protocol.
    Idea is to allow to do a 'best server selection' type of logic, in
    case there are multiple servers available to connect to.
    RFC PR is athttps://github.com/OpenVPN/openvpn-rfc/pull/30and an
    early initial implementation is available from lev.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------usgNIrcp06FiS2tpOom8eCi0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 24 June 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            openvpn releases</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Currently we're handling a number of reported issues, some
          security related.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The openvpn release 2.6.21 and 2.7.5 estimated release date is
          currently still July 1st.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Some important fixes will be backported to the 2.5 branch but
          since those are out of support there will be official 2.5.x
          release.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            ordex suggested to bring patchwork back</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This is now up and running. This will be used as just an
          additional tool.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            test latency and MTU in openvpn</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          A new feature is proposed for adding to master; ability to do
          latency and MTU tests in the OpenVPN protocol.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Idea is to allow to do a 'best server selection' type of
          logic, in case there are multiple servers available to connect
          to.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          RFC PR is at<span> </span><a
            href="https://github.com/OpenVPN/openvpn-rfc/pull/30"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://github.com/OpenVPN/openvpn-rfc/pull/30</a><span> </span>and
          an early initial implementation is available from lev.</p>
      </li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------usgNIrcp06FiS2tpOom8eCi0--


--===============2182555962473104899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2182555962473104899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2182555962473104899==--


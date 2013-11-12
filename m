Message-ID: <52823246.6010200@...1147...>
Date: Tue, 12 Nov 2013 14:51:02 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1384208842-25700-1-git-send-email-alon.barlev@...277...>	<CAOazyz1kEYtJ8gkjGZjrB67gjKGXGzFLoegrbZc-KcJnv49LvA@...278...>	<528212DC.5060908@...1147...>
	<CAOazyz0m+QWSgvGyVb3CJnp+DY0NVoGNL0ZGPjFFWsWzBPo25Q@...278...>
In-Reply-To: <CAOazyz0m+QWSgvGyVb3CJnp+DY0NVoGNL0ZGPjFFWsWzBPo25Q@...278...>
Content-Type: multipart/alternative;
	boundary="------------000804090601050306020504"
Subject: Re: [Openvpn-devel] [PATCH] ssl: enable basic ecdsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Sanaullah ." <sanaullah82@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000804090601050306020504
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Alon Bar-Lev wrote:
> On Tue, Nov 12, 2013 at 1:37 PM, Jan Just Keijser <janjust@...1147...> wrote:
>   
>> there was actually a follow-up to this patch, which was sent to the
>> openvpn-devel list on Feb 7th 2012:
>>
>>
>> Added support for Elliptic curves (ECDSA) + SHA2 family signed
>> certificates.
>>     
>
> Great!
>
> And what is the status?
>   
it was not included as this patch does not provide full Elliptic curve 
(EC) support - it only allows a user to use ECDSA+SHA2 signed certs, 
nothing more , nothing less. The Control Channel will use ECDSA, the 
data channel is still encrypted and signed using AES and SHA1/SHA2.

JJK


--------------000804090601050306020504
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Alon Bar-Lev wrote:
<blockquote
 cite="mid:CAOazyz0m+QWSgvGyVb3CJnp+DY0NVoGNL0ZGPjFFWsWzBPo25Q@...278..."
 type="cite">
  <pre wrap="">On Tue, Nov 12, 2013 at 1:37 PM, Jan Just Keijser <a class="moz-txt-link-rfc2396E" href="mailto:janjust@...1147...">&lt;janjust@...1147...&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">there was actually a follow-up to this patch, which was sent to the
openvpn-devel list on Feb 7th 2012:


Added support for Elliptic curves (ECDSA) + SHA2 family signed
certificates.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Great!

And what is the status?
  </pre>
</blockquote>
it was not included as this patch does not provide full Elliptic curve
(EC) support - it only allows a user to use ECDSA+SHA2 signed certs,
nothing more , nothing less. The Control Channel will use ECDSA, the
data channel is still encrypted and signed using AES and SHA1/SHA2.<br>
<br>
JJK<br>
<br>
</body>
</html>

--------------000804090601050306020504--


Message-ID: <4AFC56CC.8080307@...1114...>
Date: Thu, 12 Nov 2009 19:41:16 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1256844344.7529.43.camel@...1272...>	<4AFBEE55.5070202@...515...>
	<1258050832.4308.3.camel@...1272...>
In-Reply-To: <1258050832.4308.3.camel@...1272...>
Subject: Re: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/09 19:33, Olaf Fraczyk wrote:
> Hello,
> 
> No, I wasn't using --multihome - I didn't know that this option exists
> and that is necessary. I haven't found it in man page and in
> documentation on the web page. The only place where I found it (after
> you let me know about it) was with openvpn --help.
> 
> Thank you, I'll try it.
> BTW, why is it not by default?
> 
> Regards,
> 
> Olaf
> On Thu, 2009-11-12 at 04:15 -0700, James Yonan wrote:
>> Are you using the --multihome option?

James, this option is not documented in the man pages, AFAICS.  Could
that be the reason the needed use was not discovered?


kind regards,

David Sommerseth


>> Olaf Fraczyk wrote:
>>> Hello,
>>>
>>> I have several interfaces, the problem is that if:
>>>
>>> I open connection from client to server IP=Y on interface ppp1 then I
>>> get packets back from IP=X on interface ppp0
>>>
>>> For connection to IP=X on interface ppp0 I get correctly packets from
>>> IP=X on ppp0.
>>>
>>> I have read that in 2.1 it should work, but it doesn't.
>>>
>>> The OS is CentOS 5.4.
>>>
>>> Best regards,
>>>
>>> Olaf
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr8VskACgkQDC186MBRfrr/CwCffiAYHPSiJr43/adoVVi0xhQz
NMIAnRn33NnRvaZcknGSjSdRUkUEnhHo
=X92t
-----END PGP SIGNATURE-----


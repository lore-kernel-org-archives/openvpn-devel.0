Message-ID: <500589E5.20104@...1114...>
Date: Tue, 17 Jul 2012 17:51:01 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0wc=ZGhJnLfvd=AK6_Y=vTfebccmV29Fc5z2DGpJ8EWQ@...278...>
	<21316332.O9di4uRdZn@...1526...> <20120717154628.GV22125@...1296...>
In-Reply-To: <20120717154628.GV22125@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] don't treat socket related errors
 special anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/07/12 17:46, Gert Doering wrote:
> Hi,
> 
> On Tue, Jul 17, 2012 at 05:09:34PM +0200, Heiko Hund wrote:
>> if (status == EINPROGRESS #ifdef WIN32 || status ==
>> WSAEWOULDBLOCK #endif )
> 
> Please let's not do that.
> 
>> or slightly less disturbing
>> 
>> #ifndef WSAEWOULDBLOCK #define WSAEWOULDBLOCK 10035L #endif
> 
> Something like that (possibly autoconf-magick'ed) and then
> 
> if (status == EINPROGRESS || status == WSAEWOULDBLOCK )
> 
> or even
> 
> if (status == EINPROGRESS || status == EWOULDBLOCK )
> 
> (WSAEWOULDBLOCK mapped to EWOULDBLOCK, as I've seen that error code
> on some unix platforms as well) would be my favourite,
> code-readability wise.


+1


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAFieMACgkQDC186MBRfrqiXgCfZ0GhPBuXV58WX0nSOTIOGeOC
aN8An3+0TsHfXdOANg/xbIHAVxeGfEea
=m1mq
-----END PGP SIGNATURE-----


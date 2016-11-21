References: <CAFHpkQFj1ATTbGz5Nic2EKQJh2kZxXfVBZPoMvFOUFvfdhBtjg@...278...>
	<CAKuzo_iXDpmNmNH2_ZmJSSRZYTKpRik6o1U744vNLtzhwM6noQ@...278...>
	<20161121075320.GE28918@...1296...>
	<CAFHpkQGfY4Cy4wnG+zt4Y_XssPac1DVywP=DdCLGY_jWwXZ4aw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ca5cb614-d190-521b-d376-7c0c6a2df48a@...2080...>
Date: Mon, 21 Nov 2016 10:21:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGfY4Cy4wnG+zt4Y_XssPac1DVywP=DdCLGY_jWwXZ4aw@...278...>
Subject: Re: [Openvpn-devel] handle unsupported windows versions in installer
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/11/16 08:57, ???? ??????? wrote:
> @mattock , can we use some url rewrite for that ?

URL rewrite?  As on the web server?  I think that is a very bad idea.
 If you want to download a particular file, you should get what you
ask for.  The web server should not try to outsmart the user.

However, how I understand Selva (and Gerts approval), is that the
*installer* can displaying the v2.3 download URL - and perhaps even
downloading it (on request).


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



> 2016-11-21 12:53 GMT+05:00 Gert Doering <gert@...1296... 
> <mailto:gert@...1296...>>:
> 
> Hi,
> 
> On Sun, Nov 20, 2016 at 11:02:33PM -0500, Selva Nair wrote:
>> As for 2.4 installer, if run on XP, showing a link to the  latest
>> 2.3.x before bailing out is a nice thing to do. If its not too
>> much work, I would vote for offering to download the installer as
>> well.
> 
> This sounds good, yes.
> 
> gert

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYMrywAAoJEIbPlEyWcf3yGvEP/2kejd40OfjkXorkKyoCQ/LD
XZGJmZxstOSiEc//Y+7l5TcUWcDdklXjZU2DKBhEpV6RyzhzFI9Hj4IIiDtPj3EB
c2u5xzm99RJe40LVWNGZnVailgTjg6epWyYsGXeMZVHVA+GBVKEtWQJelo4Jcb/i
96+ElSUrqGTCBc993MTSzh6ejFSdkyFR5mLK9wGlgLamasim0d1Hd57LN4m9+221
QR5+PIQFCKzmOZhcFDmFBuZsjxpsNqf65Lw1dUSyekIJC49OLd3f11nancJ6nqhO
EwqS2OeM2ZKHjgLuQcGivJiZ3VbO+UFzP8d91w+r+463+xuoGzce+B/i9QcDxrLz
pi9+xfD5n+xLPQCcSOv1ALfZWSstT9N3RN9fTocE+NUlJ5y2t8FqoIhjL/5InR1r
mBbtcs+Bw4+hjCKQpRtkcIgkRtXrYm7wjZx79xeAAqNSYuz/fvROnhvyjUfcozGw
YVSER+ZwB3jBnJZ/ECTTYUz6Tzsimz6B7pRZCjrgW807jm3UJXex13wwU8fjvIF2
e06+E/tbSbRlfNeq6tZagWZMJOkHDu1EEEm0v2n7KP/vBXFWFUeM7tzJplXq42Fk
FzKMbLPBqXda/3VgjZFFD75/bK+zZYS6kG4xVvabqQkw8m7lAf1jRTKbgy7Fo2YX
n376Jqybah631uigBdPe
=Kzt/
-----END PGP SIGNATURE-----


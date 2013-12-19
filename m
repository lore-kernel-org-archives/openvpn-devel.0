Message-ID: <52B2D210.1090004@...515...>
Date: Thu, 19 Dec 2013 13:01:36 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <l8qvsn$jif$1@...1062...>
In-Reply-To: <l8qvsn$jif$1@...1062...>
Subject: Re: [Openvpn-devel] Easy-RSA v3 release planning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Josh Cepek <josh.cepek@...1085...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Here's an update about Easy-RSA v3 in case there were any lingering
> contributions or ideas.
>
> As of Dec 01, info & downloads have been available on the users list for
> v3.0.0-rc1. No replies have been sent to that thread, though a few
> improvements have been made following the release; these are slated for
> an -rc2 to be release shortly, quickly followed by an official 3.0.0
> release if there are no known issues or other hold-ups. I plan to add a
> Win32 integration-branch for openvpn-build at that point.
>
> The notable fix since -rc1 has been support for OpenSSL-0.9.8 (commit
> 8b1fe01.) While I hope this isn't a common need, the fix was simple
> enough, and this is still a supported OpenSSL version.
>
> Additional feature improvements include PKCS#7 support, some minor
> fixes, code style, and updated docs. I also plan to add in a passphrase
> change command for -rc2 so private keys can be re/un-encrypted.
>
> At this point, the notable thing missing compared to the 2.x-series is
> PKCS#11 support. My thought here is that it should either have universal
> support for both Windows and *nix platforms or be exposed as
> distro-centric additions. I'd rather see a pkcs11 frontend script that
> is targeted to each platform, and envision this as a 3.1 release target
> feature.
>
Hi Josh,

Do you think easy-rsa 3.0 would be a drop-in replacement for 2.0 by the
time we push out the OpenVPN 2.4 alpha(s)? I believe that'll happen in
Q1 next year. I can package easy-rsa 3.0 for deb/rpm distros as well as
add it to the NSIS installer for Windows.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



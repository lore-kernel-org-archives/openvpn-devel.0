Message-ID: <5362A729.3070102@...515...>
Date: Thu, 01 May 2014 22:57:29 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <536262FD.1090105@...1901...> <53627F26.1060208@...515...>
	<20140501191514.GQ16637@...1296...>
In-Reply-To: <20140501191514.GQ16637@...1296...>
Subject: Re: [Openvpn-devel] IRC & Community...
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Timothe Litt <litt@...1901...>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi,
>
> On Thu, May 01, 2014 at 08:06:46PM +0300, Samuli Sepp=E4nen wrote:
>> A few notes about where we get our patches from... in the documentation
>> we do say that "post the patch to openvpn-devel list". That was a
>> decision that was reached some years ago. However, we, in practice, do
>> accept patches from Trac, GitHub and IRC. We should probably change the
>> documentation to reflect this.
>
> Actually, openvpn-devel *is* the way, with trac being second (due to
> the way we reference every commit to a mail on openvpn-devel, trac
> patches basically need someone re-sending them to the list).
>
> Github and IRC are *not* a welcome input for patches, because it doesn't
> match the agreed-upon workflow ("ack or nack on the list, reference that
> message in the commit"), and doesn't have the benefit of trac to be
> tied to a ticket that can be set to a given milestone, etc.
>
> IRC is very welcome to bounce around ideas ("should we fix this?  if
> yes, in which way?") but it needs to result in a patch being sent to
> openvpn-devel.  Actually, this is often the reason why some patches get
> ACKed much quicker than others - they have been discussed, the reason
> for the change is well-understood, and for complicated stuff, the details
> how to tackle it might have been agreed-upon beforehand.
>
> gert
Good corrections, I was not being concise enough. What I meant that we
don't actively ignore patches to OpenVPN that come in via Trac, IRC or
GitHub. That said we don't very actively monitor those venues, either.
If there are good patches somewhere outside openvpn-devel mailing list,
we simply ask the author to resend the patch to the mailing list.

It is also not entirely true that we only accept patches sent to
openvpn-devel. Some time ago OpenVPN was split into several
subprojects[*], most of which do accept GitHub pull requests, OpenVPN
itself being an exception.

I will have a look at the developer docs to ensure they accurately
reflects our current practices. I will also try to outline the various
ways people can use get their patches merged more easily with least
amount of frustration and delays.

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] <https://github.com/OpenVPN>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNipykACgkQwp2X7RmNIqMWEQCggk8Uwwd/Ygm0NcIpahp3lG8a
t3gAoOOBHg2KPzdznjzbxqP+PoybaQek
=3D5tF4
-----END PGP SIGNATURE-----



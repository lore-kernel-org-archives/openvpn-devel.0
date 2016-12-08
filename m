References: <20161108124506.32559-1-gert@...1296...>
	<201611092014.uA9KErZf048132@...2054...>
	<8feec195-c9ed-a0bb-31c5-459bf9757ce6@...68...>
	<20161111221004.GC28918@...1296...>
	<b998265c-5220-d5ce-596c-fe400a422de2@...68...>
	<20161206210232.GN78624@...1296...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <46e73cba-a31c-c5bb-d4b0-4b83a98658f3@...68...>
Date: Thu, 8 Dec 2016 10:03:25 +0100
MIME-Version: 1.0
In-Reply-To: <20161206210232.GN78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="JtMmcawh8GEQsVGBipwcXqIqDXMEEaq2F"
Subject: Re: [Openvpn-devel] FreeBSD port versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JtMmcawh8GEQsVGBipwcXqIqDXMEEaq2F
Content-Type: multipart/mixed; boundary="VKmc1it3bM3qmwsPqfieeAhi5tA8pPaLf";
	protected-headers="v1"
From: Matthias Andree <matthias.andree@...68...>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>,
	Eric Crist <ecrist@...1286...>
Message-ID: <46e73cba-a31c-c5bb-d4b0-4b83a98658f3@...68...>
Subject: Re: [Openvpn-devel] FreeBSD port versions
References: <20161108124506.32559-1-gert@...1296...>
	<201611092014.uA9KErZf048132@...2054...>
	<8feec195-c9ed-a0bb-31c5-459bf9757ce6@...68...>
	<20161111221004.GC28918@...1296...>
	<b998265c-5220-d5ce-596c-fe400a422de2@...68...>
	<20161206210232.GN78624@...1296...>
In-Reply-To: <20161206210232.GN78624@...1296...>

--VKmc1it3bM3qmwsPqfieeAhi5tA8pPaLf
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 06.12.2016 um 22:02 schrieb Gert Doering:
> Hi,
>
> On Sat, Nov 12, 2016 at 05:43:56AM +0100, Matthias Andree wrote:
>> Am 11.11.2016 um 23:10 schrieb Gert Doering:
>>> I might be tempted to do a quick 2.3.14 release in between - there's two
>>> important platform fixes in that branch now (FreeBSD and OpenBSD topolo=
gy
>>> subnet :-) ) and Lev's recursive routing patch.  Add to that the windows
>>> block-outside-dns patch that I hope to be testing this weekend, and it's
>>> worth a minor bugfix release...  at least "before January".
>> Well, for me to update the FreeBSD port, mid December 2016 would be cool
>> for anything (2.3.14, or 2.4.0, or both) due to the before-xmas-madness
>> and to have like two weeks for smoke testing.
> Here we go :-) - Nikolaus present, 2.3.14.
>
> 2.4_beta2 is waiting for someone to bump the openvpn-devel port, but
> everyone is busy, it seems (PR#214930).
>
> I wonder what the best approach towards 2.4 in ports would be, though -
> introduce an openvpn23 port, and bump "openvpn" to 2.4.0 when that
> happens?  Or introduce it as "openvpn24"?

I've updated the port to 2.3.14 last night (there was a glitch that
didn't affect OpenVPN but cost my time), and have just committed the
FreeBSD Bugzilla's #214930.

Assuming we trust the future OpenVPN 2.4.0 enough, the canonical way for
me will be to copy openvpn 2.3.14 to a new port named openvpn23, mark it
deprecated with an expiration half a year from then or 2017-06-30 so it
doesn't make the 2017Q3 "quarterly" stable branch, and update the plain
port from 2.3.14 to 2.4.0.  All other concerns as we see fit.

> "operating system wise", 2.4.0 should be as good on FreeBSD as 2.3.14
> (because all the platform fixes went into both branches), but there
> might be hidden bugs lurking in the "non-client, non-platform" bits
> that are new in 2.4
Sure, but that needs testing. I wonder if we temporarily need -rc ports
on top of the existing -devel. Expect - due to the pre-XMas madness  -
that I need a few days to reply though. Anything important with the
OpenVPN-related FreeBSD ports, Cc: me directly.


--VKmc1it3bM3qmwsPqfieeAhi5tA8pPaLf--

--JtMmcawh8GEQsVGBipwcXqIqDXMEEaq2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYSSHhAAoJEOQSsVbv84VaLJMQAMudwJDSnpgG3EqtFksSfi0w
QDGWO4UF8EChHvK5Elwg/T/qucAwGD+TGOCBjKjQ3dD34LgEqTJfTXtC5iRffmqx
84CyNe9rnuQkO7jYhHLFbesIXaPxcsbdYWY0uv67V3yJ6xO4ap9hBdnOb6P5HcrI
UzNGr6t4ZOtiFtMBIcM3Ar1QcyzcWfe8q2C8wK/tK1Kfq6XLlxiIsUWstOn8cXiN
d2sp1qQH/8Uoj8FsLQo7HPyWOdwTnERob5yeyshJDxuHzyGkFxBedQVw98RgUIjX
hajMOtYcBWbeMRSKZDkeTozoT9zBFTUEuQPbqVcZXuLJSX20NNYUegUCqGLUZ2xd
fdU0l/PTfrAxFj1lRZPwKnXZzNixeins/SxTf3KH5lyRqQuu2MSXpzsrPSHpFBnB
7KWvy7kvnVzWROdpuYHwg1K6HzYAMz2X8iEJwMdjwDxilFQXFK3LXYmzf89zxdON
Kvyiyh6gk9U6bcAGqiaLh5SchcWHbDH8VZNuFFpY9Zvw7oOd+LpWWfGjFnLn2J8S
Db9XUTsltS7JgFrue0YGvFktr0n2Gz9Z+L8TFwv4DyziUY7CiLyzFLErrXoEvXdU
aJV+MMXbg5RG6tERWjI2zIUPAu7SiasUkTBeji1laLxCYysvKSZiW1d39A66aPTt
maq+btz/4HJRPhlGdjwL
=mtSe
-----END PGP SIGNATURE-----

--JtMmcawh8GEQsVGBipwcXqIqDXMEEaq2F--


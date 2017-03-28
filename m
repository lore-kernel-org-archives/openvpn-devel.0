References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
	<20170328060459.GM93896@...1296...>
	<CAFHpkQEWMDMs9k=6g3e5a2iMuVWMxP6zzOWZayYyL79r1U7vRg@...278...>
	<20170328065648.GR93896@...1296...>
	<CAFHpkQE9uFNLvTpmoUb3wKadQG4QHyQ6iu1dDsQnRh3hoPGOvA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1473eddd-c9f1-ddd7-3189-c9e4211c74e9@...2080...>
Date: Tue, 28 Mar 2017 14:54:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQE9uFNLvTpmoUb3wKadQG4QHyQ6iu1dDsQnRh3hoPGOvA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ok7XESplVSC3J3CcooTnowDbFeiOMKgKQ"
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ok7XESplVSC3J3CcooTnowDbFeiOMKgKQ
Content-Type: multipart/mixed; boundary="D1kWfFmBVhDKkWdE7drFrT1mCGEQaxGLf";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <1473eddd-c9f1-ddd7-3189-c9e4211c74e9@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
	<20170328060459.GM93896@...1296...>
	<CAFHpkQEWMDMs9k=6g3e5a2iMuVWMxP6zzOWZayYyL79r1U7vRg@...278...>
	<20170328065648.GR93896@...1296...>
	<CAFHpkQE9uFNLvTpmoUb3wKadQG4QHyQ6iu1dDsQnRh3hoPGOvA@...278...>
In-Reply-To: <CAFHpkQE9uFNLvTpmoUb3wKadQG4QHyQ6iu1dDsQnRh3hoPGOvA@...278...>

--D1kWfFmBVhDKkWdE7drFrT1mCGEQaxGLf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28/03/17 09:04, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-03-28 11:56 GMT+05:00 Gert Doering <gert@...1296...
> <mailto:gert@...1296...>>:
>=20
>     Hi,
>=20
>     On Tue, Mar 28, 2017 at 11:43:11AM +0500, ???????? ?????????????? wro=
te:
>     > > (See how dangerous "fixing compiler warnings" is?  :-) )
>     >
>     > this particular warning came from cppcheck, it's not a compiler war=
ning
>=20
>     Same thing.  A tool that issues a warning which is not relevant the
>     way the variables in question are used (because the values stored are
>     always way below where signed/unsiged gets relevant) - but trying to =
fix
>     it, I've misread the surrounding code and the "fixed" code would quite
>     likely have crashed, or silently corrupted nearby variables.
>=20
>=20
> cppcheck says "variable is signed, but format specification is unsigned"
> so, I had a look around, it is "byte" variable, which cannot be signed,
> so I decided to change it "int" --> "unsigned int"
>=20
> later, Gert Doering suggested to switch to uit8_t
>=20
> probably, we need to leave variable as is, just change format
> specification "%x" --> "%d" ?

Take a moment to re-read what I already quoted from the man page for
sscanf() related to %x:

   "Matches an unsigned hexadecimal integer; the next pointer must be a
    pointer to unsigned int."

Gert proposed by a mistake to use uint8_t.  As integers are most
commonly 32 bits, so uint32_t.  But that may be of a different length on
some other platforms.  So using 'unsigned int' is most likely the safest
type in this round.  Or if wanting to be really portability safe, have a
look at what Simon pointed out, inttypes.h.

Changing from %x to %d will definitely cause havoc.  This function
[parse_hash_fingerprint()] is related to parsing fingerprint hashes into
an integer value.  Certificate fingerprint hashes are most commonly
longer strings of hexadecimals.  So such a change will actually make
sscanf() fail horrendously when the characters a-f appears.  %d does not
handle hexadecimal numbers.

Again, as Gert have already said twice ... it is important to get an
understanding of what the code does before trying to change it.  Code
analysers doesn't necessarily provide the only sane truth, as most of
them is incapable of understanding the broader context.  I do not say
such analysers are useless or pointless, merely that each warning must
first be thoroughly reviewed and considered before just jumping into
changing things.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--D1kWfFmBVhDKkWdE7drFrT1mCGEQaxGLf--

--Ok7XESplVSC3J3CcooTnowDbFeiOMKgKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY2lzrAAoJEIbPlEyWcf3ywrEP/i99qXeXJVRYF4iegVlH7pYk
PALqnkiIE+B+/inum97jpVpubjHBVMCxgW/dqp3n9oLL1FxG7I8K1O44cbPyXPVp
Ms9brh2CsgD/JAl0t5M+0/RmsKHiTK0Z2/kRyU6zN1Nf5F5jIXMmUkH/hQM2jRiH
ptnhmTwxOqD1PvlWVrwwBHpBz0zZuQFyzDcSlCWanxpAnoLxVMukqfMgCY5iKLAe
ec2NjcSEz9jovOCmNurq0jecXtD+iQvqhWzLWNvD81EwUzhjRC9eiNhhlCpkjCdE
fiJOO3kahww/bAXHUXUqPgQytaGll37zGqHwnulSQJxZpGSKtFBTw8nFWxgrdfpM
BfQX2DcT0uWqyJlSBgVAnCxO0NQhbjwFI9IQxLCNbqJb04LTEfS7HpnowjzhmoDT
8X0PV7stUS/KI3tbxZuocbqDg0+gTqOHghBkdwUE6S9gAgqvfhLisHM98GfTF02n
JYbqNtE1whX2FRD4oc3Uu4MrvodT69AAhOjEuM6iNF3LzbhAgz1YO8rFdapWvAis
CJsUnTYul+Is/Qws3gs49WKToR0Mt8VjEqf8IVS0T97xIRu+FcLIIOnFN1YBRznL
RctiHtgqmY44sLtQVujyB1dqZYbDl4+4zMn7jc8xERXlM4umL94WEO6D7N3pvdB1
w0lc4GOahmSZARBG1cCJ
=qlxs
-----END PGP SIGNATURE-----

--Ok7XESplVSC3J3CcooTnowDbFeiOMKgKQ--


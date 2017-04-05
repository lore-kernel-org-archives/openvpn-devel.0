References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
	<c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f4e7f2e8-5310-a982-ffb3-67c0f0abb3ec@...2080...>
Date: Wed, 5 Apr 2017 11:18:56 +0200
MIME-Version: 1.0
In-Reply-To: <c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="415VANwLFWO6tXxJWueg5ncQmRq9RODLE"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--415VANwLFWO6tXxJWueg5ncQmRq9RODLE
Content-Type: multipart/mixed; boundary="KKTid0jW6bGbqn2gcvb1aRvJHWl3i9dwx";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <f4e7f2e8-5310-a982-ffb3-67c0f0abb3ec@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
	<c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
In-Reply-To: <c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>

--KKTid0jW6bGbqn2gcvb1aRvJHWl3i9dwx
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/04/17 09:31, Steffan Karger wrote:
> Hi,
>=20
> On 05-04-17 08:57, Gert Doering wrote:
>> On Wed, Apr 05, 2017 at 06:34:34AM +0200, Simon Matter wrote:
>>> I've attached v2 now which works without any config change:
>> [..]
>>> I prefer this version as it allows everybody to profit from it without
>>> touching any config files.
>>
>> I can see the reasoning, but 25% feels a bit on the high side :-) - so
>> let the ratholing begin what the number should be.
>>
>> Steffan, any views from the crypto side of things?
>=20
> Not really.  I think the feature makes sense, and I like that this will
> only *substract* from the set time (so not exceed any set limits).
>=20
> (And I agree that 25% feels on the high side - my gut says somewhere
> around 10%, but I have no analysis to show why that would be better.
> I'll leave picking that number to you.)

The default is 60 minutes.  With 25% that means a time window of 15
minutes, so reneg-sec will occur between 45-60 minutes.

I see this can be too much for some sites, and perhaps too little on
sites which have many users.   With 10%, the reneg-window is reduced to
54-60 minutes.  For larger sites, this is most likely too small of a
window - though far better than everyone at "exactly" 60 minutes.

But I am also wondering if this randomness should only occur on the
first renegotiation.

If you have a 6 minutes time window and 100 connected clients, there is
a big chance that at some point the randomness will cause a similar
congestion again, as multiple clients to have the same delay.  With 25%
that chance is lower, but the chance increases again with more clients.

So what if this randomness instead only occurs on the _first_
negotiation and then respect the --regneg-sec setting?  Then clients
will somewhat spread out and then keep a certain predictable
renegotiation load.  And if using 17%, you get a time window of roughly
10-11 minutes where renegotiation happens.  With 100 clients, that means
roughly (with a theoretical, ideal and even spread) 10 clients per
minute.  Which is more reasonable.  With 200 clients, it is still
getting crowded but not too bad.

But all that said ... I think it would be wise to have an optional
argument to --reneg-sec (in addition to the 'sec' argument we have
today) which can be used to further open or close this time window.
Larger sites will most likely want a larger time window than smaller ones.

Btw ... is --reneg-sec pushable?  (Too lazy to check the code, man page
says "no").  If not, it would probably be a good idea to enable that.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--KKTid0jW6bGbqn2gcvb1aRvJHWl3i9dwx--

--415VANwLFWO6tXxJWueg5ncQmRq9RODLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5LaKAAoJEIbPlEyWcf3yyy4QAJmSoKsK53UOR/2WaUsG/IfP
LBDryGkSJs6DTWGQu7MiGR8fTbsbHv4BJnLLm+4JJh7V0zeRy6xGlAp6viF+fnOC
7J3XuyVPFt3p5oO+bmlISdtSUZIGUBMhHx2Fpx0chUfXdayHLf7v5WCcohyqoKYH
vuQIMfYxZ69z0AgDsiOcL4oB9SogBjGdzSWBs45TfVMJRo3UoSJE6S4NG6PIDgKc
pxNJ0b1I75SnGnNklz1DrEKe/mdxbts+Vrgsj54adXNu2lRhnZspvBhKxRl2UDML
syGDEcJeHWOlkE+lv6cMJgfwVX7Pedm90avD9EOBRMGSBQqnv37WJZ8zP0kuNh8y
dGlZm0rgW+DTWRo9fU5QOToJYZc/+jY657cIgLUG73GPDNsHNdzXvULv8v977Uu8
kUb2UYddU1f5lxStT7Wsic5rj7ZzHhD0mI+Uq686NunPLwobPpjANuIGS3bYfTgp
FTwsAePLhWvZwaDGZfsHX20/sHguGfWSa0Ig4ecnw8KpA/hTqz/Ho5N+oPWxQS7P
7ZovSK0WrOhSKYLsDmnyOzIimuuC+HVUOcTBh31qoABFqy2aeBLpf86YBLUK/0zB
3x9Pln+52z01b7PxEeYi1KhYm8weob/n2chcw4jxAPKx0mBYm8+Vqpa7ls+8oTxe
f8IWdMtTWrdXcn/wnN5y
=GuAt
-----END PGP SIGNATURE-----

--415VANwLFWO6tXxJWueg5ncQmRq9RODLE--


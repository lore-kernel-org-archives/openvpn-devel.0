References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
 <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
 <5351a640-22bd-5a9f-b0a0-f80b3109ddb3@...2080...>
 <9ff688b9-9925-962d-1e75-11098907c71d@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3f3d8111-2292-82a6-6499-386834c61613@...2080...>
Date: Tue, 9 Mar 2021 21:53:12 +0100
MIME-Version: 1.0
In-Reply-To: <9ff688b9-9925-962d-1e75-11098907c71d@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="apYlSgtslvYQovz2sJy1yUIdIA0zVfxnY"
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--apYlSgtslvYQovz2sJy1yUIdIA0zVfxnY
Content-Type: multipart/mixed; boundary="QUVd5d5xvaQUi1xYYgEaZgTlsIyIIJED5";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <3f3d8111-2292-82a6-6499-386834c61613@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
 <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
 <5351a640-22bd-5a9f-b0a0-f80b3109ddb3@...2080...>
 <9ff688b9-9925-962d-1e75-11098907c71d@...277...>
In-Reply-To: <9ff688b9-9925-962d-1e75-11098907c71d@...277...>

--QUVd5d5xvaQUi1xYYgEaZgTlsIyIIJED5
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 09/03/2021 21:04, tincanteksup wrote:
 >
> I have swapping issues all the time and I can't add more RAM.
> I don't want system wide disk encryption.
> And I don't want an SSD either.
>=20
> I do not have the money to keep up with modern hardware.
>=20
> Having openvpn --mlock is exactly the right choice for my home
> system.
>=20
> Please, do not remove --mlock from openvpn.
>=20

How much memory does your OpenVPN process consume?  And if the process=20
(or task in kernel lingo) is active (not idling), it generally will not=20
be swapped out.  If it does, you are already running way to much on your=20
host.  So you need to prioritize what that host should really run.

OpenVPN's --mlock does not save you.

And in fact, the kernel may as well swap out the memory pages containing=20
the program itself and just keep the data pages allocated by the program=20
in memory.  Which will result in a sluggish OpenVPN performance regardless.

This gives a brief overview which might help you see what happens:
<https://scoutapm.com/blog/understanding-page-faults-and-memory-swap-in-out=
s-when-should-you-worry>

And even though you don't want SSD.  At least consider if you can get=20
hold of a reasonably performing SSD with not too many GB and activate=20
that device as a swap device on your host.  It will not be optimal, but=20
at least the general swapping can go faster if you have a decent=20
SATA/SAS controller.

 > Please try to put yourselves in the place of the average user,
 > for once.

The average users I know does not push their hardware beyond its limits=20
so much it hurts the overall performance.  Those I know would start=20
planning for an upgrade.  Or get an RPi4 and run OpenVPN on it, as it=20
got a reasonable network performance:=20
<https://notenoughtech.com/raspberry-pi/2019-raspberry-pi-network-speed-tes=
t/>

But openvpn --mlock is never the solution to performance and swapping.=20
Never ever.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--QUVd5d5xvaQUi1xYYgEaZgTlsIyIIJED5--

--apYlSgtslvYQovz2sJy1yUIdIA0zVfxnY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBH4DgACgkQhs+UTJZx
/fJRVhAAm/FhVIXptHI/D7nY1tkCym7FrNsEREBW1NBNo3uYDvmZHMjqjInBEyAa
VtzyPjlHBBlA31P9YWh+e4NQrIl1YYt6fuuxcGFXTNBB4m6V4P4oG1XCInZoqaVk
fUKrmKal07ZqfmfI4JaB/+QSS7B4U/D2OwN+s5MqSN1jaaKSu+luJa9nsNu7IH8s
jadHV8ynsThyk0BNaJtenhyGmSzTM18+ZCa72kUzKIKu3RCCS68X0Wnit2sAC6Ph
FBOde/hd9zC8gwUhoMnOzZ/KSAbd0DLKFuodAdKVvIt89SbGHEJsPY08drBdeVYM
SUFnI7xndA655XyL2damWCn2cld39hJ+I8/292bUkfkKxDo21wWlNUhIAXY7HICA
CHf87SnwpqdwnYZCVkbN6v3XEHNH0eW+oJXr1jRIbmXSeQV/6Xl4QsKQVlXGuoF/
8R9SjKk4sPfwLIRh3Eqk8WbsmjuXC5Lq63Q9EvRy//k8XRSvobIHShcsKzVq3puJ
VedFtxbJChfnGRCyZs7iVcyQxjlfiBJTzz+o/P4tFYguWZVJiBMm5EgA11jad3kV
Hd5FPOmzdnVyyibTa4VI4CPFsrvH3fdgo2as3mKc4ft94HjwvCv7sbAyAMenBO2T
Yo6iv/el3ETdihyXz/LJqew9GNGHxLGUX5pKAW82LeBg+Al1GFo=
=A7xx
-----END PGP SIGNATURE-----

--apYlSgtslvYQovz2sJy1yUIdIA0zVfxnY--


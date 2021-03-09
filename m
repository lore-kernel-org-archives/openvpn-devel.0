References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
 <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5351a640-22bd-5a9f-b0a0-f80b3109ddb3@...2080...>
Date: Tue, 9 Mar 2021 19:52:36 +0100
MIME-Version: 1.0
In-Reply-To: <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BI9OacPQg8uNOrcugpjaftHkEzxO5njdg"
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
--BI9OacPQg8uNOrcugpjaftHkEzxO5njdg
Content-Type: multipart/mixed; boundary="NkahYx7OP0evl4lA5CZJ4BHXMgRXMOkMf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <5351a640-22bd-5a9f-b0a0-f80b3109ddb3@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
 <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
In-Reply-To: <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>

--NkahYx7OP0evl4lA5CZJ4BHXMgRXMOkMf
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 08/03/2021 14:45, tincanteksup wrote:
>=20
>=20
> On 08/03/2021 08:06, Arne Schwabe wrote:
>=20
>> Looking at this feature=C2=A0 from today's perspective, it feels like on=
e of
>> OpenVPN's boutique features. Was probably useful at some point but
>> doesn't really make much sense today anymore. Esepcially with what is
>> written in the manpage. Today you rather would use full disk encryption
>> or disable swapping rather than to rely on OpenVPN's --mlock.
>>
>> That being said I am against your patch, I am just wondering if that is
>> a feature we need to keep at all.
>>
>=20
> Having all openvpn data remain permanently in memory also offers
> a (small) performance boost.
>=20
> Your alternative offers would impact performance and be system wide.
>=20
> Therefore, I for one disagree.

mlock() itself does not really have any impact your these arguments.

Yes, mlock() is about ensuring that OpenVPN can allocate a certain=20
amount of memory which will stay entirely in RSS the memory pool as long=20
as the memory pages has been locked.  But it is not a system wide knob;=20
it's a per process knob and applications can even turn this on and off=20
at will (given they have the needed privileges for it) during the=20
lifetime of the process.

Due to this flexibility to when you can enable and disable memory=20
locking, it is also clear it is not intended to be used as a performance=20
knob.  It is designed to be more a security related feature, which in=20
OpenVPN's context is there to avoid getting memory containing keying=20
material being swapped out to disk.

On today's hardware even telling the kernel to not swap out a few=20
hundred megabytes will also not result in much noticeable performance=20
improvements.  To feel the difference, you would need to have some=20
really ancient hardware.

If you care or have issues with performance related to swapping, you=20
need to revisit your swap setup - or add more RAM.  A few hundred=20
megabyte related to OpenVPN will not make things better or worse system=20
wide on your system.  Fixing the real reason you have swapping issues will.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--NkahYx7OP0evl4lA5CZJ4BHXMgRXMOkMf--

--BI9OacPQg8uNOrcugpjaftHkEzxO5njdg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBHw/UACgkQhs+UTJZx
/fJA3Q//SBT4xIo9IHTGiAt6711aIv/mI1QacOWdpL4Rwo7qm2qUdYvToUgFT5VG
G3yVLZPNKqmM6es9GCmm27a0NCBa2R7f8fZY5dkzezeQSvntnhjwKlWwgPnWGPmv
cqURMOcXxGiaXSg8tlTaiyQDvgyTVkK+yqnvaJDL2WaROhSsXNIlJkxVmfsEEck+
GpEiBIHqQ2y7bzMRooaU7o5vPUQehhVRmnCDzMKvFDpbwreek0jzZaCQ2nv/Lk6H
IiUlSwEVWQBZ43YeuTvovT2Dqdl4azhuKDcWUPkHru2zZ8R4jvxWwdor5u6Yec1J
QMN0UctVZxbMNTnvVWhqJvmAOvaTwOZq/vI0pz4m3E+1G2MPlx5kqTSy7FbmhX4t
KAq3vOK4nsCEZPUlDzn0smWe/htVcGerXMPxO6x6JGX91CnjZePRsUWw4do6+5yg
J7khb6ILeDqQ2CeMQgTV1OVZL3StshGSitXG+Z9ES01w6E8MdXi1mPNe+VEV2P0t
EmA/WCLhJSGbLlH2/ig/QKr407UtUm3NKSRRwkd9dmnxOU3mbvabO/zh/cnASHxX
U4TuBhZjD4LklZ3wANjjDI8BUS6Ai/vkHXFCYgIqc5kKoRySCtkuWnEgWerIpG8W
6tOHs8DAhLwiS4JtweG5CQYVL2QmcqwUYBwaMCGQppPu9+ZJlEc=
=5Ve2
-----END PGP SIGNATURE-----

--BI9OacPQg8uNOrcugpjaftHkEzxO5njdg--


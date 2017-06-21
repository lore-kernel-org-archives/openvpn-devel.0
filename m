Reply-To: openvpn-devel@lists.sourceforge.net
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
	<20170621151835.GU97029@...1296...>
	<103f1dec82c50941570c7103355b8457.squirrel@...2257...>
	<20170621154928.GX97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <41fdab48-8ce0-0734-9829-a17206a9fbcc@...2080...>
Date: Wed, 21 Jun 2017 17:58:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170621154928.GX97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ISLAmXj0WF2mxO41HTggn4wjmmrFMboAO"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Simon Matter <simon.matter@...2249...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ISLAmXj0WF2mxO41HTggn4wjmmrFMboAO
Content-Type: multipart/mixed; boundary="GK9Xob1H1clEeIM6ksNnva4KaaESMlRsN";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Simon Matter <simon.matter@...2249...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <41fdab48-8ce0-0734-9829-a17206a9fbcc@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
 <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
 <173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
 <5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
 <20170621151835.GU97029@...1296...>
 <103f1dec82c50941570c7103355b8457.squirrel@...2257...>
 <20170621154928.GX97029@...1296...>
In-Reply-To: <20170621154928.GX97029@...1296...>

--GK9Xob1H1clEeIM6ksNnva4KaaESMlRsN
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/06/17 17:49, Gert Doering wrote:
> Hi,
>=20
> On Wed, Jun 21, 2017 at 05:25:32PM +0200, Simon Matter wrote:
>>> .gz is built with "make distcheck", .xz right after from the same
>>> tree with "make dist-xz".
>>>
>>> What differs?
>>
>> The check sum of both extracted tarballs, not really their content.
>=20
> Ah.  Yeah, that's one of the drawbacks of building two independent
> tarballs - timestamps in the tar header (IIRC), so the end result always
> differs in a few bytes.
>=20
>> I suggest to create .xz from .gz instead of building another tarball. Th=
at
>> way the extracted tarballs from .gz and .xz share the same checksum ->
>> less confusion in case something goes wrong - as it did with 2.4.2 and
>> now.
>=20
> David, you're listening?  Should be an easy-enough change from what=20
> we have now... ("gunzip <...tar.gz | xz >...tar.xz" or however you
> do xz balls) :-)

Hmmm ... not a bad idea.  But do we really need tar.gz at all these
days?  Why not just make autotools generate tar.xz by default and be
done with it?

Or to put it differently: Which platforms lacks lzma/xz support these days?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--GK9Xob1H1clEeIM6ksNnva4KaaESMlRsN--

--ISLAmXj0WF2mxO41HTggn4wjmmrFMboAO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZSpeaAAoJEIbPlEyWcf3yDBIP/RMuF0QUw1obkSvyE4tBnSYG
XHNgQCLFvStt0qJkijBB3fLoweKM3j6nHPwxXbTBGasV/Jwr5xxWKXKhjRijI/pU
zjo0Hq7sBV8lmbXnW47zV99Pih9/qO+kEH7j49Duk6D/CdZ4IcGy5Yvt2BHGX2sc
E9EK/glp9n/PKMeST0Agf998HU62MQpYAPcZMkDM+g101nelvQI5ovrr7amLERqh
dVlw30/ySAhFp/jxSsuV1uMSu8By75NOrXfHKut8seMt02pmZeib1kMa7Tqsi6FE
A1jM9Jyu2osLo3xZ7He9mWbeOKDm/fIMwzhM59H2Mj2SJx4fAmAlTQsSzKSNFeIR
R0bIMsY6AVFe2HTdsNsNEpJHekVoiNTsTlD5t3yczzd5QZfGhfmJ2XU38Edxog3l
mmcrNKJt+NsZV/zEHKFXfi0bqQ7eH/xCtW7BVNMmFj6rSg2C5EJzFVjB9m1L+ijv
EySTCJCgI63vsliQm0AK9ps7pv4Y5EN/osvWoX5DI1WWlBEIyndOWBiDpPjAaZnj
NtJkFaQdyKLbSm8/BcaBLh1/MLzJz3hV7EYg46zk3id0/ib/oXx1PaSQARG7vf64
ckIwDhyiaq9pMWm3Un+Lit0eIGlwzgDBBIVF+zgDlqoxaS0OIUvo/fhaS8kVN97V
EQqiBz/VmceqiYwyCZQe
=9MBA
-----END PGP SIGNATURE-----

--ISLAmXj0WF2mxO41HTggn4wjmmrFMboAO--


References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8f263a80-903e-ecfc-b87a-a29a897f1326@...2080...>
Date: Sun, 21 Jun 2020 22:57:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200621111403.GP1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9KAOE0NsC6aOMHOcXEVVDtjHO3tv65m94"
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9KAOE0NsC6aOMHOcXEVVDtjHO3tv65m94
Content-Type: multipart/mixed; boundary="FSpe0R3tGxlmRoGkBSTa7f8lXCkU9LKhG";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <8f263a80-903e-ecfc-b87a-a29a897f1326@...2080...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
In-Reply-To: <20200621111403.GP1431@...1296...>

--FSpe0R3tGxlmRoGkBSTa7f8lXCkU9LKhG
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/06/2020 13:14, Gert Doering wrote:
> Hi,
>=20
> going through OpenVPN threads that went stale - I think this is=20
> actually a nice addition (read: other people have already asked=20
> me if this can be done).
>=20
> On Thu, Mar 05, 2020 at 01:53:12PM +0100, Jan Just Keijser wrote:
>> So, for what it's worth, I've dusted off the patch again and rebased it=
=20
>> to the current openvpn master tree. See attached. Note that I did only=20
>> rudimentary testing, as I don't use Windows 10 a lot and I was testing=20
>> using a mingw cross-compile only. In wireshark I *do* see that the=20
>> correct DHCP offer is sent to the tap-win adapter.
>>
>> Also note that I implemented multiple search domains by separating them=
=20
>> using semi-colons, e.g.
>>
>>  =A0=A0 --dhcp-option SEARCH example.com;example.org;example.nl;example.=
de
>>
>> etc as that was easier to implement
>=20
> The patch looks okay-ish on quick reading.

Feature-ACK from my side as well.  But there are a few things we need to lo=
ok
more into.

[...snip...]
> More interesting is the question "which option to use" - it should
> be synchronized between openvpn platform handlers.  So if systemd-networkd
> uses "SEARCH-DOMAIN" it would make sense to use that for windows
> as well.

Nit-pick, systemd-resolved is the target service in this case though.  But =
it
is related to systemd-networkd.

But I agree, we should synchronize this a bit.  IIRC, there might already be
somewhat partial support for this in OpenVPN Connect clients as well, which
might also be used in Access Server.  I would also expect the OpenVPN Cloud
service to facilitate such a feature.  I have recently been working on
systemd-resolved support in OpenVPN 3 Linux as well, and reached out earlier
this week to Jonathan (update-systemd-resolved maintainer) to see if we can
join forces better and standardize on a common understanding of the DHCP op=
tions.

I would also like to at least consider pulling update-systemd-resolved (or a
similar approach) into our OpenVPN distribution, as an alternative to the
rather hacky pull-resolv-conf scripts we're shipping.

I quickly spoke with Arne late on Friday about it as well, and we might also
want to consider some IV flags from client to server as well, to flag suppo=
rt
for features like split-dns (which at least systemd-resolved can provide).

> Does anyone know about commercial VPN providers basing their clients
> on OpenVPN?

I will clarify with our folks internally how this will influence OpenVPN
Cloud.  I can't imagine many other commercial VPNs depending on such a
feature, this is more typically a business feature than a consumer VPN
feature.  There might be a few ones implementing or needing such a feature,
but if they don't appear here and raise there concerns here, I don't think =
we
should spend time on them.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--FSpe0R3tGxlmRoGkBSTa7f8lXCkU9LKhG--

--9KAOE0NsC6aOMHOcXEVVDtjHO3tv65m94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe78myAAoJEIbPlEyWcf3y5UUQALb73mfgGhpot+7VKhpE7cGB
+cCVIV0YjVQ0s8zF9Ke5AW/OigK6/Coma8j9zcOvFG/1+TJSzba/ZEf6w+9Jxy4L
B09AgyDcs+whN4xtNWdLkIlQVX6XczNteEndrVEeTvbIs/nJWK07zXgG/ZrICOnM
3NMSlrADwblmnEFiwKq2w50iHvnlk7+ubLwYLyMrBBT+zBFU6daeueC7Jquy33Ty
h+I2me8pzUXexUarp3XsPIyZBeITJ71xzhkrgibbeTbTYOCt7OfK9EPPlTf2UMi2
oiT5IfCpTBVF4mEVILVBy6V43Nil1SIx4ojP3pzPEf66b02VQMQ1Q86GMgFKJ7H9
X2UzFkd3H3tzIyv5R+HkY5/86ajhLPSurwja1Ida0Ympn0fm0w7ejAeZoOm3BOuf
Wkzkbqlxc71ouYgbxWSfrYjSDYr82RbiySOHi9tzgvkE30H9O98nuxVzYUfz9PIL
B6vflAW1EprmF7FwC3/a1Fwre17p5QyQtQEzS8gnaJNa+blMvNZoeJrSL20bQgeS
xuPqT54ph26tENMZA67EQLuGF34TDJWXOQZ6Nen9i2RnnpDC+g13mxBlos1rG3pJ
LG+0/3ReiV0b4uQV44FhiKnsTiBd0WkeOCP97Dd8vggeGYIXIVktypRtoI+f6XFk
ORy0ZpSJr+T7WAmMRrGi
=R+TU
-----END PGP SIGNATURE-----

--9KAOE0NsC6aOMHOcXEVVDtjHO3tv65m94--


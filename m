References: <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <885f8b43-cd49-a88e-4a69-4913c0636e56@...2080...>
 <56e393a1-0838-9888-d178-96df4e9c277f@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6cc72b95-3f72-f974-258e-c0b0e5efa28a@...1227...>
Date: Fri, 3 Jul 2020 11:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <56e393a1-0838-9888-d178-96df4e9c277f@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vyUglGyktOCGtgI7LYqq0E8PmupUUS1JS"
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
To: Jan Just Keijser <janjust@...1147...>, David Sommerseth <openvpn@...2080...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vyUglGyktOCGtgI7LYqq0E8PmupUUS1JS
Content-Type: multipart/mixed; boundary="wvhh0WOzqOPFo2nncmMFkcnQ6NcIokHjE"

--wvhh0WOzqOPFo2nncmMFkcnQ6NcIokHjE
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


>> The main purpose of that RFC is to ensure we handle DNS and
>> --dhcp-options
>> consistently across all OpenVPN implementations we care about, and
>> that we
>> document this properly.
>>
>=20
> I see one as an implementation issue (can we specify a particular DHCP
> option more than once) and one as an OpenVPN protocol issue.
> I fully agree that it's time to think about and overhaul the DNS
> settings for OpenVPN but I also believe that further abusing the option
> 'dhcp-option' is not the best way forward.=A0 The option 'dhcp-option'
> only really applies to the Windows tap-win adapter as that is the only
> adapter where you can use DHCP to add/change settings.=20

This not even remotely true anymore. Basically all platforms will accept
the dhcp-options for modifying the DNS settings.

> AFAIK even the
> new win-tun adapter does not use DHCP for this. Hence the term 'dhcp-'
> is moot.

Yes. Of course we can specify nicer sounding names for these options and
that also break all kind of backwards compatibility for little gain or
we document that the dhcp- prefix in these options is for historic reasons.

Arne


--wvhh0WOzqOPFo2nncmMFkcnQ6NcIokHjE--

--vyUglGyktOCGtgI7LYqq0E8PmupUUS1JS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7+998ACgkQFRhsZwKx
RFS78w//TdLewhejcbrDJFIEcbBdHO1m6fx4obz+zpXSYlkJgZFfqCh8TklrovXt
4HqpnVgcN1eXCOu1vHwou4l+8muO3xgO4mL/lpSxTSbWlN1WRgmp2zD/41wHLUIs
z3dHN/laraQkMm7bjMptRULvRj+E8mjOYky0VZDY9FFFPq5vXXVaAHjb7i5HKLk7
IjX5oI6XAkEJwwteSf1QeLQqa80fhHyf0Fjb/9rYQ9lauKS7jjFDNi65MrjaL96u
arwqKelepiN+x64ZswAeCJLidWDAcdpsdgDdJUK3q0xe0MyiCdsYwywDVFNQ8wsL
Dr9f8uTSH6AfbVf8QIqRKHIolqekSDtKjbL0tKBTZ0o7njM0bT0QEQkNTlwHORbF
vG0tFgDiZQZpabEzi3CdWbftNDFsTzaJ1OZxujCjfUhLDWrIRmlrYhotdWkN5hQ2
4v7bEVbVAZBOs4AOfZozAeH6M0x1yzvtLkTrXcRPLAaDXj3EMvLIHhwrq54XAGsY
+3k4Ft+AQsjLKj/XAELYc0Az5SRwiYizJTvjUFbmmdB1QUnC/3bQx7dMMivFMJAc
KOV+yFGEHB4g2oa3A3MpkZGvZ0qL1jN2gYzcBJVb2OoIVIQRRUSFcEeFHEC3w2vZ
YERGzz6aB1AvU1tBh5vuc8X0fESexn0tHsErewFnlrkRpyOFlC0=
=8kue
-----END PGP SIGNATURE-----

--vyUglGyktOCGtgI7LYqq0E8PmupUUS1JS--


References: <20170115061718.3218-1-praiskup@...1347...>
	<8e0e7b9b-3f54-88c4-6880-a3736a3a87ea@...2080...>
	<10918281.H3KHJINfQl@...2234...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2ec1296a-d633-2ad5-ea1a-ffc3b5668495@...2080...>
Date: Sun, 15 Jan 2017 18:53:30 +0100
MIME-Version: 1.0
In-Reply-To: <10918281.H3KHJINfQl@...2234...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6eQnBxFRDB3c9aIQxjiXEpOQdUOMgi9Mn"
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
 argument value
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pavel Raiskup <praiskup@...1347...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6eQnBxFRDB3c9aIQxjiXEpOQdUOMgi9Mn
Content-Type: multipart/mixed; boundary="h7Pd23Xr0TMKLRK9FjH0IF9j6uvrlcppc";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Pavel Raiskup <praiskup@...1347...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2ec1296a-d633-2ad5-ea1a-ffc3b5668495@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
	argument value
References: <20170115061718.3218-1-praiskup@...1347...>
	<8e0e7b9b-3f54-88c4-6880-a3736a3a87ea@...2080...>
	<10918281.H3KHJINfQl@...2234...>
In-Reply-To: <10918281.H3KHJINfQl@...2234...>

--h7Pd23Xr0TMKLRK9FjH0IF9j6uvrlcppc
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/01/17 14:52, Pavel Raiskup wrote:
> On Sunday, January 15, 2017 11:08:38 AM CET David Sommerseth wrote:
>> On 15/01/17 07:17, Pavel Raiskup wrote:
>>> Adding a new --with-ca-bundle configure option.  It's argument is
>>> used as default CA file when no --ca option is specified at
>>> runtime.
>>>
>>> This option is primarily designed for systems where users are
>>> allowed to manage trusted authorities for whole system (in one
>>> consolidated file; usually implemented in 'ca-certificates'
>>> package).
>>>
>>> Signed-off-by: Pavel Raiskup <praiskup@...1347...>
>>> ---
>>>  configure.ac          | 5 +++++
>>>  src/openvpn/options.c | 9 +++++++++
>>>  2 files changed, 14 insertions(+)
>>
>> As this was mentioned on a Red Hat Bugzilla (bz #1413343 [1]) as well,
>> I'm reiterating my argument here for closing that bugzilla as notabug.
>>
>> I completely agree with Steffan, this is a NAK.  Such a feature would be
>> a dreamscenario for The Great Firewall of China and similar national
>> routing instances which implements complete network surveillance.  It
>> would make it extremely trivial for them to implement a MITM OpenVPN
>> server which would affect users not being aware of this issue.
>>
>> This feature would elude users configuring OpenVPN it is no problem
>> using certificates from public CA issuers.  This is a VERY BAD idea!  We
>> should help users configure OpenVPN in a secure way by default.  Not the
>> opposite.
>=20
> Ack, I originally thought about this as tool to solve "packaging issue".
> We have corporate-wide authority, and people usually have it stored in
> bundle.  But I got the point, and such a shame mistake -- there's too many
> trusted CAs.

I would recommend seeing the CA file being part of the configuration
instead of a packaging detail.  And you can embedd the CA inside the
configuration file ... just do this in the config:

  <ca>
  -----BEGIN CERTIFICATE-----
  ....
  ....
  ....
  -----END CERTIFICATE-----
  </ca>

This replaces the 'ca /path/to/ca.pem' line in the configuration file.

Otherwise, for enterprises doing their own packaging ... it is also
possible to install the OpenVPN CA file in /etc/pki/.... which is easily
done with RPM files which again can be pushed out through internal
repositories or Satellite.  The distributed configurations would then
just need to use 'ca /etc/pki/tls/cert/openvpn-ca.pem'.

It all depends on how often it is expected to distribute configuration
files vs how often the CA certificate is renewed.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--h7Pd23Xr0TMKLRK9FjH0IF9j6uvrlcppc--

--6eQnBxFRDB3c9aIQxjiXEpOQdUOMgi9Mn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYe7caAAoJEIbPlEyWcf3ybiAP/3BZtPkFGBWrAHdawpLncWHq
SG5eAHeJt1LBs3mWIeIsXpmtfrA7fdGP3NakhHTG9AdhVXJ7mTTPImgmmE3inxgg
+zs5FEXahWYobOBRS4q908gQmmL/NqzEqYCJ/6sPJ1OO9suHGh1O7tioD1dWuM+n
WU6sxQzfC5eI1DdgKSYbM4zQTJ39Z5ZqTHj5ZuNadKvgwFpBUCMWAOPDoRTjFBjp
r4Q3tmG/iU3KnpK4YO2wiCV+iU+wJRQ0+glef3yYGcjSncxH6ssB+wfBUdcKjQKq
jOpJXBJtHnYVJzhGMJoGYa+oT+7eYvhFDpXfbD5gA/Ioxp/tO2laSjsBwA7bnMwc
0ZY2pLJkjeUfc2/pLQlAuVs22WDzyTr8z+re0KawGhuPKMbGjWr0LVFiCAaHEDnG
uyHAzO2IEQ2S40RDzi44GhiFQ8KuE/dFADZ93QuG9cU7V77zKwkfWB3L3wFEtc8t
18BRCE+uJqu6X/v2QIEOmoDj7Y1JH5UWYcZKCtDRr4JYuooMmcIhm4AWYWcnpVNq
hSjU5wwcv2bcqIHTB8cAcYndQTuKOjuHfpAlPNfVPbNVOHNti0D49C9VoN56ThtO
pRPcWby6b5vrLrUCg1jgd4VV5Ge0A6NK3D4fzV/Tuje9AdDvkCCQpsHev4L7yGLJ
25Mos6Hw7qdBTwqhZjYn
=6oqQ
-----END PGP SIGNATURE-----

--6eQnBxFRDB3c9aIQxjiXEpOQdUOMgi9Mn--


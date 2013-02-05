Message-ID: <51111E7A.4000108@...1114...>
Date: Tue, 05 Feb 2013 16:00:10 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <510E43DE.20008@...1147...> <510E7997.8040909@...1114...>
	<1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig870FD1A8D9546599D43A9CBA"
Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig870FD1A8D9546599D43A9CBA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 04/02/13 08:43, Adriaan de Jong wrote:
>> -----Original Message-----
>> From: David Sommerseth [mailto:openvpn.list@...1114...]
>> Sent: zondag 3 februari 2013 15:52
>> To: Jan Just Keijser
>> Cc: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
>>
>> On 03/02/13 12:02, Jan Just Keijser wrote:
>>> hi,
>>>
>>> what is the second option to '--crl-verify' supposed to do? in
>>> options.c it sets a flag SSLF_CRL_VERIFY_DIR which then triggers the
>>> function 'verify_check_crl_dir'. However, this function does not seem
>>> to do anything....
>>
>> Quickly looked at the code ... with the 'dir' flag (which sets
>> SSLF_CRL_VERIFY_DIR), it's no longer a typical CRL file validation.  If
>> you create (touch) a file in the defined directory with the file name
>> matching a particular client's serial number; the connection will be
>> denied.
>>
>=20
> Confirmed, with the footnote that this is a weird way of going about thin=
gs.=20
>=20
> I would like to suggest deprecating this option from 2.4 (or 2.3.1?) onwa=
rds, and forcing people to either:
>=20
>  - Create an actual CRL file. This is not difficult. In general, people u=
sing OpenVPN should be managing their own CA in the OpenVPN world.
>  - Failing that, create a custom script to do this.
>=20
> I'm always open for discussion, but imho this should not be core function=
ality in OpenVPN.

I agree that this directory based "CRL" with empty files shouldn't be a
core part of OpenVPN.  This is in my eyes what --tls-verify scripts is
supposed to solve.  I also agree with JJK, that implementing proper CA
path support makes a lot of sense.  Even though PolarSSL lacks this
support now, I believe Paul wouldn't instantly object a patch
implementing a CA path support.

However, I'm not sure it's a good idea to remove this feature in 2.4 or
earlier.  There are people depending on this feature.  And it touches
the same discussion topic we had at FOSDEM regarding --compat-names and
--no-name-remapping.

If removed, I would say it should be removed in OpenVPN 3.  We can start
warning about it in 2.4.  However, I'd really like to have James
feedback on this as well before we just decide to kill it off at a later
release.  Just because I want to avoid the same situation/discussion as
we had at FOSDEM.


--=20
kind regards,

David Sommerseth


--------------enig870FD1A8D9546599D43A9CBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlERHn4ACgkQDC186MBRfroU1gCgqX6g/e1HnicUKD0sr5UJCK/Z
f64An35GCg6H/hbfNpQPlQ15rsKGy3Mg
=Eupq
-----END PGP SIGNATURE-----

--------------enig870FD1A8D9546599D43A9CBA--


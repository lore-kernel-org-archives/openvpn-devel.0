Message-ID: <534D7BF6.6050200@...1114...>
Date: Tue, 15 Apr 2014 20:35:34 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20140413152613.GT16637@...1296...>	<20140414193422.GN16637@...1296...>	<534C42AB.7040700@...1114...>
	<20140415074239.GR16637@...1296...>
In-Reply-To: <20140415074239.GR16637@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4eEaOHE292GeRdaE5Nwi08jX2b3kEVxDe"
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4eEaOHE292GeRdaE5Nwi08jX2b3kEVxDe
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 15/04/14 09:42, Gert Doering wrote:> HI,
>
> On Mon, Apr 14, 2014 at 10:18:51PM +0200, David Sommerseth wrote:
>> Regarding your patch - the PolarSSL stuff
>>
>> +char *
>> +get_ssl_library_version(void)
>> +{
>> +    static char polar_version[30];	/* "at least 18 bytes in size" */
>> +    version_get_string_full( polar_version );
>> +    return polar_version;
>> +}
>>
>> version_get_string_full() is crappy due to the "at least 18 bytes".
>> That's ugly.  Can we please ensure that we at least adds a NULL
>> termination in polar_version[29] after version_get_string_full() ...
>> just to reduce the risk somewhat, in case it suddenly gets longer.  Then
>> it should (hopefully) be somewhat harder to get a buffer information
leak.
>
> Different approach:
>
> char *
> get_ssl_library_version(void)
> {
>     static char polar_version[30];
>     unsigned int pv =3D version_get_number();
>     sprintf( polar_version, "PolarSSL %d.%d.%d",
>                 (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
>     return polar_version;
> }
>
> this is well-defined (polarssl/version.h), and guaranteed to not overflow.

I like this.  I know that Paul has promised to never exceed 18 bytes.
But you never know what some distros might do.  They may modify these
strings to provide more fine grained info.  But this approach above will
actually always be far more predictable.


--
kind regards,

David Sommerseth



--4eEaOHE292GeRdaE5Nwi08jX2b3kEVxDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNNe/gACgkQDC186MBRfrqfggCgotW4cW9apzdNjbXiOS1jrxR2
aWUAn1gu3YA0NsibvTuP991OBO6iOrzl
=49wP
-----END PGP SIGNATURE-----

--4eEaOHE292GeRdaE5Nwi08jX2b3kEVxDe--


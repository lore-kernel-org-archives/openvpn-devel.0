Message-ID: <507E82B0.7020706@...1114...>
Date: Wed, 17 Oct 2012 12:04:32 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <507E7822.1070006@...1114...> <507E7A7E.5010303@...1147...>
In-Reply-To: <507E7A7E.5010303@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF4C6C7F4C6D502858AD4AD34"
Subject: Re: [Openvpn-devel] RFC - Usage of --script-security with the
 'system' flag
Reply-To: openvpn-devel@lists.sourceforge.net,
	openvpn-users@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4C6C7F4C6D502858AD4AD34
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/10/12 11:29, Jan Just Keijser wrote:
> Hi David,
>=20
> David Sommerseth wrote:
>> Hi all,
>>
>> I've been reviewing a bug reported to the v2.3 code base.  We're in the=
=20
>> beta phase currently, and this is a bug I'd like to get fixed before=20
>> we're moving on further.  The bug is related to the use of the 'system'=
=20
>> flag in --script-security.
>>
>> <https://community.openvpn.net/openvpn/ticket/228>
>>
>> The use of the 'system' flag has been deprecated for a long time.  And=20
>> it is really a potential security issue to use it, due to shell=20
>> expansions which might happen.  The preferred (and default way) is to=20
>> use execve(), which is far safer and does not do the shell expansions=20
>> while executing the script or binary.
>>
>>=20=20=20
> on Linux the difference is not that big, however watch out for Windows=20
> servers - with the old (system) like functionality it was possible to=20
> specify e.g. a VBS script directly. With the 'exec' style you need to=20
> specify the vbscript.exe, the full path to the script etc etc. There's=20
> even an example about this in the book you're reviewed for me ;)
> If at all possible I'd leave in the 'system' like functionality , as it=20
> is very valuable for debugging scripts. We can add warnings about it=20
> being deprecated and the fact that there's the risk of memory leaks ,=20
> but I do see value in this feature.

Hi Jan,

Thanks a lot for a good input!  Yeah, I didn't have Windows too much in
my mind when looking at this issue :)  My ugly habit as a non-Windows user.

When using the 'system' flag, this is put into the log:

   NOTE: --script-security method=3D'system' is deprecated due to the \
   fact that passed parameters will be subject to shell expansion

I agree that it's a convenience to just "dump the script file" directly
into the configuration file for debugging, as this 'system' flag
supports.  But wouldn't it be an increase the overall security if you
also had to explicitly define the script parser as well?

In *nix the explicit parser is set by the very first '#!' line, and the
file needs the exec bit set.  In Windows, it will basically try to
execute whatever has a system registered file extension.  I actually
wonder what happens if you provide a 'openvpn.ovpn' file as an --up
script ... given that OpenVPN GUI is set to execute .ovpn files when
double-clicking them.

I'm also thinking that in Windows, you either need to have:

  --script-security 2 --up "%windir%\\system32\\cmd.exe myscript.cmd"

or

  --script-security 2 system --up myscript.cmd

Right?  While in *nix you just provide the script file directly (due the
'#!' + exec flag solving the script parser).  So it would anyway need to
be documented for Windows users.

Would kicking out 'system' be such a burden for Windows users in that
perspective?


kind regards,

David Sommerseth


--------------enigF4C6C7F4C6D502858AD4AD34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlB+grAACgkQDC186MBRfromywCgsFp9U1RGPEApxt2pe6oPbAAK
1/kAmgM/ogjVtwi40jiCIah008QPTiQG
=ckU/
-----END PGP SIGNATURE-----

--------------enigF4C6C7F4C6D502858AD4AD34--


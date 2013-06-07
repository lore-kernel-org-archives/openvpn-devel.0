Message-ID: <51B1CC9D.1060404@...1114...>
Date: Fri, 07 Jun 2013 14:05:49 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1366393268-27392-1-git-send-email-gert@...1296...>
	<1366393268-27392-2-git-send-email-gert@...1296...>
	<517269DC.9090903@...1227...>
In-Reply-To: <517269DC.9090903@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2RPHSSQIJXUWSWUCETMGE"
Subject: Re: [Openvpn-devel] [PATCH 1/5] Added remote-override option.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, James Yonan <james@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RPHSSQIJXUWSWUCETMGE
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 20/04/13 12:11, Arne Schwabe wrote:
> Am 19.04.13 19:41, schrieb Gert Doering:
>> From: James Yonan <james@...515...>
>>
>> OpenVPN SVN r8126 (2.1.20)
>>
> I am not sure I like these remote-override but the patch is small enough
> to include it if OpenVPN AS really needs it.

I completely agree with Arne.  I find this feature vague in it's purpose
and I'm pretty sure it will be misunderstood by users sooner or later.
I do see that the GUI can benefit from such a feature.  But I strongly
believe this is something the GUI should have sorted out *before* even
starting OpenVPN and then push the correct --remote directly to OpenVPN.

What I feel is difficult about this current approach is that only
hostname is overridden.  So you need identical servers configured for
this to function.  If one server uses tcp and another one udp, or there
are MTU differences or using different ports ... this override function
will not work at all.  If it would just override a specific
pre-configured connection profile,and maybe even with a possibility to
override multiple or selected connection profiles, then I think this
would make more sense.

But if OpenVPN AS really needs it and fixing AS will be too much of a
pain, lets pull it in.  I'm not happy about it, but lets fix this later
on.  Let's ensure this commit points at this mail discussion too.  It's
more important currently to get OpenVPN AS code base merged with the
community code base currently.


--=20
kind regards,

David Sommerseth


------enig2RPHSSQIJXUWSWUCETMGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGxzKAACgkQDC186MBRfrrAzQCfX/fChep5v5p4ktfgMJ/spm6G
c74Ani7go5IKrDcdIZyfe7z0ZwAhfwjR
=pMg2
-----END PGP SIGNATURE-----

------enig2RPHSSQIJXUWSWUCETMGE--


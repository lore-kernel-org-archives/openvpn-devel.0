Message-ID: <515043B9.10404@...1227...>
Date: Mon, 25 Mar 2013 13:31:53 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAM2vnFNeWvOfRqVM2nnhkFYqEq4V4GXCKi7x5h6SU_tBZB2A_w@...278...>
	<515040F4.4010905@...1114...>
In-Reply-To: <515040F4.4010905@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2DALXCLPJTSLUDVVDNJAU"
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN Obfuscation for git-master
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DALXCLPJTSLUDVVDNJAU
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 25.03.13 13:20, schrieb David Sommerseth:
> On 20/03/13 16:49, Siren 1117 wrote:
>> Hi all,
>>
>> I modified the obfuscation patch to work with git-master. And I also put
>> it on Github: https://github.com/siren1117/openvpn-obfuscation-release .
>>
>> Hope it could help someone.
> Your patch still have not changed *anything* commented in this e-mail:
> <http://thread.gmane.org/gmane.network.openvpn.devel/7285/focus=3D7293>
>
> I am in particular worried that you have not put any concern into the
> RC4 comments.  To seed you more on this topic, please read this one
> (especially the "So what's wrong with RC4" paragraph):
> <http://blog.cryptographyengineering.com/2013/03/attack-of-week-rc4-is-ki=
nd-of-broken-in.html>
>
> In addition, you have more in-depth info here:
> <http://blog.cryptographyengineering.com/2011/12/whats-deal-with-rc4.html>
>
> Why am I concerned about this weakness when RC4 is only used for
> obfuscation?  Because if the encryption key is easily recovered, the
> obfuscation doesn't really work.  Any blocking firewalls of certain
> sizes can easily add checks on for extracting this RC4 data and try to
> retrieve the keys.  This way they can detect the obfuscated OpenVPN
> traffic, and decide to block it.  You can of course change the key
> again, but it's just a matter of time until the new key is retrieved and
> your back at start needing to change the key even once more.  And when
> this is needed to be done in 10-15 minutes intervals, people will start
> complaining about OpenVPN's non-functional obfuscation.  This is a no-go!
>
> So please!  Before submitting any more patches of this "RC4 obfuscation"
> approach, come up with a better and improved solution - at least don't
> ignore the weaknesses in RC4.
>
> And as I already said: The TOR project already have written good
> obfuscation methods (obfsproxy) - learn from them! Then doing something
> similar will make far more sense to include into OpenVPN.  Reusing the
> obfsproxy source code will even reduce the risk of errors and lessen the
> maintenance of the OpenVPN code as well.
I think the correct approach is to create a plugin mechanism that allows
arbitrary connection methods like:

<connection>
remote my.remote.bla xxxx
connect-plugin obfuscate.so
</connection>

The plugin would then try to open the connection and return a fd to
openvpn so that all the other is transparent for openvpn. This allows a
good integration for stuff like obfuscation that can change quickly
while providing a nice and clean interface for openvpn.

Arne


------enig2DALXCLPJTSLUDVVDNJAU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFQQ8AACgkQe8+cMNS4zRds/QCgqtMqDO5b+MWBfYV0dpAefGkm
Pa4AniCqCYCBxOGTEeNsFCvVK13gBNrT
=j9Xp
-----END PGP SIGNATURE-----

------enig2DALXCLPJTSLUDVVDNJAU--


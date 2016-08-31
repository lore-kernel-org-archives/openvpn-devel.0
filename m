References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
	<CAFHpkQEQUM7U40aYeKQy=rA7tiRcGxUrFxusOrLHhq-MfPUgrA@...278...>
	<3fda1204-41dc-39a2-4fe6-cad66cd86c88@...2080...>
	<CAKuzo_iNNRCqfn=+9nv_n25mUF7akOW_6cec_JhU6dMuaV4nqQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3511ca4d-1d4a-a674-9be8-0cfe9859264c@...2080...>
Date: Thu, 1 Sep 2016 01:19:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iNNRCqfn=+9nv_n25mUF7akOW_6cec_JhU6dMuaV4nqQ@...278...>
Subject: Re: [Openvpn-devel] Modernising the management interface
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/08/16 23:25, Selva Nair wrote:
> Hi,
>=20
> On Wed, Aug 31, 2016 at 4:11 PM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>     > It is not being planned to remove the management interface.  If
>     > D-Bus works well for everyone on all platforms, then we can disc
uss
>     > what to do next.  But as of now, I have no plans to remove this
>     > part of the code.
>=20
>=20
> That's all what I wanted to hear -- as long as the management interfac
e
> (MI) is not going anywhere, no need to panic, right? I like the simple
> design of the current MI that makes it so easy to debug over command
> line, support on virtually any platform without external libraries etc
.
> Even with D-Bus one has to still send messages specific to the
> application and the UI developer has to learn a few new keywords. Not
> very different from the current state of affairs unless we have a use
> case that is not easy to support over the current MI. I have never use
d
> D-Bus so no idea of the status of Windows support -- I believe the
> reference implementation as a windows port, not sure how well maintain
ed
> it is.

I noticed that the upstream D-Bus community have embraced the Windows
port and included all fixes for Windows there.  So it is probably
somewhat better maintained nowadays.  But I have not looked where to
download things.

If I've understood some of the D-Bus docs correctly, it should also be
possible to use D-Bus without a "master daemon" running too, but that
needs to be investigated further.

No, no need to panic :)  But I think that GUI's may also have some
advantages of using D-Bus too, such as getting a more instant
notifications when something goes wrong, or if a user needs to
re-authenticate.  But I am completely open to explore these areas and
not set things to stone now.

I am also open to look at alternatives to D-Bus on Windows too, if there
is something native which is worth looking into.

Actually, I also wonder how this would work on Android as well.  Android
have the binder interface, I believe, which is somewhat related but not
the same.  And if such an interface would be useful there.

I'm not too thrilled about needing to look at several implementations
resolving what D-Bus does in OpenVPN (similar to the OpenSSL and mbedTLS
modularity) ... but if that is considered a requirement, we will
definitely look into that.

> One limitation of the current setup is lack of a security layer which
> makes passing passwords, keys etc not very safe. I suppose D-Bus has
> security features?

Yes, it does.  Again, I have no idea how this is resolved on Windows,
but I know that on Linux this is coupled with polkit (formerly known as
PolicyKit), where you can define policies on the different methods
exposed over D-Bus.  So also here it is possible to gain additional
control without too much extra work.  The policies being defined can
include things such as:

   - with or without password

   - if the authentication can be "cached" (need to authenticate
      each time or only after some idle time)

   - if it can be an "inactive user" (not having a session active on
     the local console, such as ssh) or if it must be an active session

   - If the the authentication must be an admin user, or if the current
     user would suffice.

Plus polkit can do even more fine grained control as well, through the
rule system.

I'll admit I don't have full overview of all you can control via these
policies, but it should truly suffice for our need.  A reasonably nice
and easy introduction to polkit can be found here:
<http://www.admin-magazine.com/Articles/Assigning-Privileges-with-sudo-a
nd-PolicyKit>


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXx2XsAAoJEIbPlEyWcf3y5IAQAMDqTGXXH/mUMNeK1GlBBaT5
mrmmz7ARybBT7zQCIkrcr/6DgVOZQ4n3JOQWaPSFhIyzw7BTwg0WqlTMRBpmCazG
2y3HuscaOfW3AUKtns+LyScLkQyeZwWKn2Y03Y03KEKVAXz26hrXSrIl02ZUYSqo
0rv9fk8D8iiK52vAUGFe4TQnmW0fcj5dQu6Q2UQFtPNHPuL/DYJcHTd65DgYX6Dw
G5KkEF9o0Bwzx2rPBqMoyn1McfD+iOJFKmrVCczH62z16B/0f6VuE5ssdM8i9GD7
uYCY/kAqv3xmf/M42gWQpAh7nVWtUxd5ny49+X8ZiAbU3G22pWzFuz+DpxF/oL0s
cQIuoxoWCgQsHqTwSKZsUvZ5iacbxY9KIJ1t1xAMwDr16pvIo7IX2tXVhe7DqQl2
dKTo9kGARdQK/fahdMg136JJFXHZm7zTJtGyAouYUf+tgTAjj76my6y0UfxDIZYM
ua2MHSAm6xVH4OFEsoqzACY76V10VeU21WJ26KYW/GvdiXq/mIV2W57x+vb1fG52
DVdvfXtuHZQIhNEIRYZ+9Kob104ojegDMp3IaCa1FPxZr6vuKtIDSrCRUlD2qDlH
1f7ozDALLsYEDxcYULq8U4QLH6N9qR8Zz8R4Hgea3uONNa/xX9hVGxfGxwXjyRiF
jlAkS3mF4yHhhJ/9WDG0
=3Dmyng
-----END PGP SIGNATURE-----


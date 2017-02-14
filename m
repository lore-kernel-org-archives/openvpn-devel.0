Date: Tue, 14 Feb 2017 21:00:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170214200042.GX93896@...1296...>
References: <CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
	<b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
	<CAOAUwZGs4934tC9P3zvmrN6qp-L9vkSMOi3_UwXT4Q7NCvdp5w@...278...>
	<CAKuzo_gwjVdfLbqAQH=4PyvKU2Hha6cd3dJZGkRBTkDTCiB7aQ@...278...>
	<CAOAUwZHAuSdL6q5z40maNPCQQmN0715c1+go0NNmPAvmJZwkFw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gIHggtDV96iaw8wO"
Content-Disposition: inline
In-Reply-To: <CAOAUwZHAuSdL6q5z40maNPCQQmN0715c1+go0NNmPAvmJZwkFw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier W <olivierw.ml@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--gIHggtDV96iaw8wO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 14, 2017 at 08:32:42PM +0100, Olivier W wrote:
> So, finally I've been able to use "git-send-email" with TLS. The
> problem was a patch used by FreeBSD.
>=20
> If there are any FreeBSD users on this list or for the curious, you
> can find more information on FreeBSD's bugtracker:
> https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D214335#c10

Funny enough, I was already subscribed to that bug... :)

> Or if someday you update git, Perl or one of its components
> (Net::SMTP::SSL is deprecated) and "git-send-email" break, you may
> find a way to solve the problem in the link posted above.

I find it a bit weird that this not addressed upstream in git itself,
but is burdened on the operating system maintainers...  but most likely,
I'm missing half the story.

whatever - it works now!  :-) - and now to address your actual patch!

Steffan...?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gIHggtDV96iaw8wO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYo2HqAAoJEB2Cnv7KVigSzVEMAILYcIGqbhr4RtQUqUbMcYdC
QL+/GngcybGkrefv9uHybjLAJ0F1s6EFWqUXGs4B7sEQAcPA8C3ose/XoVgyq0Q9
Xzv7XIlc59irTwEscN3evuUBLBvkJs7PYp+rEmrF0HG7ASHOqIrtdrUqSv8rA7er
eMnoyXTiVwGYLDTL+2yvA6MTjaf1DXO0A4SzD9PORR8Z32YEuUSwprxq95ROoQ5L
jKbZvpph4DouWRzTHezFznTbo95IJT7zTu3lwxx8ASJpiIDrSFop5rRvN5dbC8B4
Yhb1P0dLCLQv9qI0odbTfgKshclWEp2qsm44aM0Gcu8o/n3hAglL+x/sFXyR9l3z
HSupd6wdI96xNwfAV+1xlUzp8ubnIXE+igwGx3jXA7hL+1bA4i0Bpz86PekIbDFM
AkLb9rhl2OAqZ7GRXYE0548ap9TDZ+AnHPxRpIyaQuSz+pa1zQwqiZSIGl9ZI/69
2eXFt6iYBTgWsaqBeQTH3eXBZ2Z1wN4qPME5VJrt7A==
=UgKj
-----END PGP SIGNATURE-----

--gIHggtDV96iaw8wO--


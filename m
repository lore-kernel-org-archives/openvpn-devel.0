Date: Sun, 17 May 2015 19:24:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150517172423.GQ382@...1296...>
References: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
	<55464DBE.4010203@...1856...>
	<CAEsd45RoxhHiXGTAQwaPHHPnqfMk=iHjkoJOzeU_WaSU72MKXQ@...278...>
	<555893F1.9080207@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xYEba/cIt2nZJmCG"
Content-Disposition: inline
In-Reply-To: <555893F1.9080207@...1856...>
Subject: Re: [Openvpn-devel] OpenVPN argument parsing of most options
	ignores "extra" parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--xYEba/cIt2nZJmCG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 17, 2015 at 03:13:21PM +0200, Steffan Karger wrote:
> That sounds reasonable to me.  However, I tend to be easier in accepting=
=20
> (potentially) breaking changes than other community members.  So I think=
=20
> it makes sense to put this on the agenda for the next IRC meeting.=20
> Iirc, the next one should be tomorrow at 20:00 CEST.

+1 :-)

I do not have strong feelings on whether this should be a warning or=20
a hard error, but it's generally good practice to let the user know about
"unexpected extra arguments" (or, turned around, totally annoying if=20
software just ignores stuff on the command line without at least telling=20
you) - so all for "doing something about it".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xYEba/cIt2nZJmCG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVVjOx6kuBuNlUUl1AQIfIAP/dmHs8JUZFlS4B3fp0AM2ChA2EcQVLLhx
9YQDuGScHG9gHSjZpK+wGHlyUf5v5YDq4UC6I4DojkOR9BFOoP573lwWtK2CYEmG
rCEDxTFTkcwvTLlnDB5iLCWAPMdm0pyUVgQTsHFYRRuAfNfi0SX828cf2gT88hRH
vcXNaH6yrtM=
=iuEa
-----END PGP SIGNATURE-----

--xYEba/cIt2nZJmCG--


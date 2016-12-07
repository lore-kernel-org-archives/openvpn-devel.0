Date: Wed, 7 Dec 2016 09:29:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161207082908.GT78624@...1296...>
References: <1480707729-19578-1-git-send-email-selva.nair@...277...>
	<20161206203324.GM78624@...1296...>
	<CAKuzo_hvXg5HWrgc1Gd++iZwtTf2aekKDuc1KHufZ+HXZ66znw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dnBRaVjvtun1Q0Od"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hvXg5HWrgc1Gd++iZwtTf2aekKDuc1KHufZ+HXZ66znw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Correctly state the default dhcp server
 address in man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--dnBRaVjvtun1Q0Od
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 06, 2016 at 05:37:15PM -0500, Selva Nair wrote:
> Yes, it does work in tun mode (easy to test just use offset 0 on command
> line)

Good :-)

> I had posted a patch ( a year ago?) which sets the offset to 0. I did not
> remove the offset variable though it makes sense to get rid of it... Anyw=
ay
> the patch never got any attention :)

Apologies.  I've seen the patch but got distracted.

We should get this fixed after 2.4 release in master (along with lots of
other "now we go clean this up and refactor everything" :-) ).

For "fixing strange parts of openvpn" patches, please feel free to remind
me every now and then that feedback is missing.  I'm not extending this to
"all sorts of patches" right now, though, as I can't make promises for the
"big change patch series"...

Anyway: Samuli, how's patchwork proceeding?  Speaking of "tracking patches".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dnBRaVjvtun1Q0Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYR8dZAAoJEB2Cnv7KVigShScL+gOWp2M9u57bQ/EsMYEHRJZ9
bvwjDR18KgfGvqn6bs9Gyov9w24LWRAz+MY+Rdo6e/bvlR0vsS3EKfacKA9mR91h
lzvM3pHyZUR57wu9PgteRuhXISe+CF+rPcq7BcYzStgaR3SkKAj4l0xDj5pBQW9h
/lmDTTcALwpeC1BTXbgrbQqdp9IQDuGdxNj/hyU1iUgiVkCRnXQPEd390+s0w6Kc
6qhWRrQuyE5udceTZC1Ld98fxdzJ9hyAIesP6/lUtZBIhRNqDr9Y+MxQNsC6NCct
rDripxISd3vshiTDNVv0YOW35+ohrWW810njWkqWF3HLB2MUSTRWuoS52VHfSFv1
qoOB6j6Z2zyCm/wVMBDpCRlgTKu/2lDA4UGTIUkFgxFhaV+ospJynMDWKXlQHn4E
ovantBqcHQ241d3vwekbUbkkC7kIwf9CkGhcvklriv5BrJ2mBZ9ZnTTNY38NMZwu
Fc+Y1WnL4qEdKbj3H+xTnoOyPD1Agep6iYXGYKJjwA==
=0zKz
-----END PGP SIGNATURE-----

--dnBRaVjvtun1Q0Od--


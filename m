Date: Tue, 1 Nov 2016 12:10:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161101111010.GH28918@...1296...>
References: <5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
	<9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fSbKhQ/kwrfWINy"
Content-Disposition: inline
In-Reply-To: <9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--2fSbKhQ/kwrfWINy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 31, 2016 at 11:55:08PM +0100, David Sommerseth wrote:
> How long will users be willing to wait?  I'd be really surprised if 2.4
> is out the door before Christmas 2016.  When also considering we've said
> that 2.4_alpha was soon ready for about 1 year or so before it really
> got released, I'd even say I am overly optimistic.

If we could spend our time on a somewhat focused work on 2.4, instead
of exhausting ourselves discussing feature backports to 2.3, this could=20
happen faster.

And more *focused* work: less rounds of review, buildbot explosions, etc.,=
=20
which eats up everyone else's precious time.


Grumbling aside, our feature page for 2.4 sees us in reasonably good
shape - all the major work has been done, Samuli has done some amazing
work on automated windows testing, and all the test reports we've received
so far have been "yeah, it works".

So, what is missing for 2.4 (please update the page as you go)?

I see TLS record splitting, which I have no idea how invasive this is
going to be, and how much time is needed to make that happen (and to
test it).  A number of trac tickets for specific corner cases (like,
FreeBSD 11 with topology subnet).


I still think the timeline "end of 2016" should be doable - there's
some reasoning to meet that: it will make the next Debian release.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2fSbKhQ/kwrfWINy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWBh4EakuBuNlUUl1AQLrnQQAxcQ10Gp5psxrNoy5Bngsa3jD69IqLi7x
eqjpypr/wGb2jEIz10fLJVJe4/vpEHTkYfqkXsSFTyaaH/jmr3dyo+6UcFKzPAmy
ecu1/2pZHjW+2CRLad9MP8aSuPCbwyH0eN6ncgc2ckf+8Aw2F6qpWT95iwXhvWWW
8eAPo27x9jU=
=be/9
-----END PGP SIGNATURE-----

--2fSbKhQ/kwrfWINy--


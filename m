Date: Tue, 7 Aug 2018 23:01:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180807210155.GJ55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180807185937.GH55859@...1296...>
 <20180807190716.GI55859@...1296...>
 <CAKuzo_i70Ws4U9-VTzVug4aLu11Z5nWsFe2dzCvUDPWEhDXi7w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WFBruw+1XAMIZlde"
Content-Disposition: inline
In-Reply-To: <CAKuzo_i70Ws4U9-VTzVug4aLu11Z5nWsFe2dzCvUDPWEhDXi7w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WFBruw+1XAMIZlde
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 07, 2018 at 03:38:43PM -0400, Selva Nair wrote:
> > If I press return at the challenge prompt, it seems the SCRV1: string
> > is not formed the way the plugin wants it, and I end up with
> >
> >   pass=3DSCRV1%3AMTE5NQ%3D%3D
>=20
> How to format this if response is empty is not clearly documented
> but my impression was that the second ':' (%3A) is required.
>=20
> management-notes.txt specifies the format as
>=20
> password "Auth" "SCRV1:<BASE64_PASSWORD>:<BASE64_RESPONSE>"

OK, so something is bugged, and it seems it's not the plugin.


> When password is read from stdin, its formatted as (from misc.c line 358)
>=20
> buf_printf(&packed_resp, "SCRV1:%s:%s", pw64, resp64);
>=20
> So that should also contain the second colon.

This is a bit surprising.  So "something" is eating it between
"openvpn command line client", "openvpn server" and "plugin-auth-pam".

Interesting.

> > in the LinOTP URL - so, it didn't decode it, because the second ':'
> > was missing (if I put a blank in there, I get pass=3Dmypin%20).
> >
> > Is this intentional?  Should it be that way?
>=20
> If you are constructing the SCRV1: line using a custom UI,
> I would suggest to add the second colon. If using Windows-GUI or running
> OpenVPN from command line we'll need to fix this one place
> or the other.

Command line client (git:master/5961250e776194a4, what I happened to=20
have lying around), run with a config file that has

  auth-user-pass
  auth-nocache
  auth-retry interact
  static-challenge "token value: " 1

in it, and pressing <return> at the

CHALLENGE: token value: _

prompt.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WFBruw+1XAMIZlde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbagjDAAoJEB2Cnv7KVigS0CAMAKq0hvQ4H7LzZNdEmZ/XXGma
9R8Ziv9YtF4ZdGncSKk/B3iwT5FI4oSKViI7qCKRWgwiPx0Q6IraR3mMNcXUSYRx
92WPubhygR7UUXVNMfjFJEfOj1lSskgBfnwA6jxUToP/BQBScqYaUvoSsOJCtYgm
haK+AX941SKRwHhGSIoG/VweS9ReLw9+Bd+HwkmMIPdeVFhqGSDYWtMG4KsD1y52
crn56dgOPdPyVcny/yEp6ir5cjTRly58SLg8fR6bE/Ap0Dl04UjYhQSEpvX2EiRM
20ySlwXfKkXlqpAfKIQOnsAY5UCy/FYCMHblyYZcbgxyKBimGsmMRNXioMhNsSRQ
pCBqBXHbQkvdyEdEZWgQ9QCB+zsOrX2905Ecz2Nz4euO7V0LV3C3zbwXCvbZaDYf
6vkXCzRjSzWYpkwCd4wYyGP0FT6kK8rO2Ld2XujvQpyi0qeAdB8HsSjzrVV2mRzI
cpqwANZRX9JxHxn3CXsi93yeh4czrLPGkJp8lMYeHg==
=eHB3
-----END PGP SIGNATURE-----

--WFBruw+1XAMIZlde--


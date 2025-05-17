Date: Sat, 17 May 2025 11:42:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aChaC74pfU6ywph8@...1296...>
References: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
 <a7e11016a114631f281dc7c769e55533a80728ac-EmailReplacePatchSet-HTML@...2715...>
 <CAEsd45SvAi2eqYYqfajzVnwxK9TuN6cO9PskoQk2oNAC8pu_Qg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mzCyRDN4oCod/wM5"
Content-Disposition: inline
In-Reply-To: <CAEsd45SvAi2eqYYqfajzVnwxK9TuN6cO9PskoQk2oNAC8pu_Qg@...278...>
Subject: Re: [Openvpn-devel] [L] Change in openvpn[master]: dns: don't
 publish env vars to non-dns scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: heiko@...515..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--mzCyRDN4oCod/wM5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 19, 2025 at 06:02:46PM -0500, Jonathan K. Bullard wrote:
> Does this mean that if there are --dns options which override
> --dns-options options, then (for macOS) the foreign_options_N
> environment variables related to DNS will not be passed to the up/down
> scripts? That would be a a *major* breaking change.

As a side note: we discussed this a lot, and I think we've come up with
a compromise that addresses existing deployments, and provides new and
exciting functionality if needed.

So, if all the DNS related patches are merged, what you have is

 - *if* there is an --up script, it will receive "foreign_options_N" for
   DNS config, no matter if the config was pushed by means of "--dns ..."
   or "--dhcp-option DNS ..."

   In this case, --dns-updown is not run by default

 - the --up script will no longer receive "dns_server_..." env variables=20
   -> compat scripts can use "foreign_options_N", and new scripts should
   use the --dns-updown hook

 - if there is no --up script, or you use "--dns-updown $myscript" or
   "--dns-updown force", the dns-updown script will be called to take
   care of DNS.  In this case, if an --up script is run, it will NOT
   receive any DNS related information (no foreign_options_N) to avoid
   setting DNS info twice.

 - "--dns-updown disable" will unconditionally not run the dns-updown
   script, for those users who do not want OpenVPN to manipulate their
   DNS settings - this includes me, on servers that might have multiple
   OpenVPN sessions, and "nothing must interfere with my server's DNS
   config".  Somewhat of a special case, but there for a reason :-)


... and, as Heiko has said, this is all 2.7 stuff, as the change is much
too big and has too much potential to break something for users to sneak
this in a minor 2.6.x release.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mzCyRDN4oCod/wM5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoKFoLAAoJEB2Cnv7KVigS2zwL/2T0QlyAZE3sCKCeoD0RrGXc
iGG48b/ceFv5QF3nBg6LKVbijSNKVAe5XjcSkYrapcYKEUvwrGdHeYg0sdHfqXJG
QbsOvolRbaGaGlIloWnuDcG8BqGdHC7wqxk2J/DBqtcaGTb+unSjB2z+Janfixxz
SBgJ4SRa/33wcsYPo5cLzAEe+BysWvhDy0GznLUC5cqf2N0EiPO3ffMZfBmdrynV
yU7Epw8c/IUJR5ST4QzEcZ/3WEqkngAYcIyuP3yL+ygZWovj6jW5K+YER9GCP1w4
k/tbZWkhZSFkiOVt4Eaw7jTC9uCkelroJfHbRYhDglDOk6Li6vrLODe7Yw65TX+f
/U6bk+KvFhW/mr3EzyJcz0t3VLgiL/QtjQ4/490OPWPOQklpKAoYa7Q8joFPRjll
R70wFGTjJxRkTV9wnbuH4iBvv7f+OThNW1qGD1QTre/IhxzAV9k9uaygzPhE57YT
H8fbxHaKeQ7+SsQwDGbXzdoKBMKrnnGea7/lmhUWaQ==
=w4ua
-----END PGP SIGNATURE-----

--mzCyRDN4oCod/wM5--


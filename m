Date: Fri, 26 Apr 2019 19:53:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190426175354.GJ31008@...1296...>
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <24961e3f-19da-a7b3-50db-d67aef792b62@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SMcH7s1wxTzO87UA"
Content-Disposition: inline
In-Reply-To: <24961e3f-19da-a7b3-50db-d67aef792b62@...2181...>
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Pieter Hulshoff <pieter.hulshoff@...2499...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>

--SMcH7s1wxTzO87UA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 26, 2019 at 03:46:53PM +0200, Antonio Quartulli wrote:
> Therefore if you are shutting down a client and restarting it within
> this short timeframe, it is expected that you won't get any PUSH_REPLY.

Restarting the client (as in "full program termination and restart")
should cause a full new handshake, and the "do not send PUSH_REPLY twice"
protection *should* not apply.=20=20

If it does, it's a server side bug.

This behaviour (Dazo's "no soup for you" patch) was intended to avoid=20
confusing clients by sending them multiple PUSH_REPLYs if the server was=20
slow and the (same) client impatient.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SMcH7s1wxTzO87UA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcw0WxAAoJEB2Cnv7KVigStoEL/j0wqhBKE9qif/7OqV08nNLp
OynkUkXyA1IQ5HaA1mQx1F1C6Nt/RRd+dbHWh7EHhVP8x8gITZrv6bI+RJNHmF6i
6a2Cdw3u8/He0jDK67fBr/dlgVdUU2dRVTx33VosIj8I4tYCswfoF4NiDQwmoTJn
hxR0Jk5+0pHYSMNRcViUVrKG1IcmjbHqaGBo1Sxqd1LTCyrx98AeNxZMBz553YsV
y2aA2t3wda61mdgXtXIkMwZKVba6j3yFhNi7cjI3+SxWH/vZVkv99bMSmhwh1uyS
K3ekeo4NlKTy18QS/NgWkrsTVhT90qYAQ9Qqsf7dqarY90zHBSlx5gAMGp8iwnEH
a4vHoG4VcXuYtt1OdUFymkf9xmRwI9007jCCLO0upu/curOngO1KUkoXRXPcKqx7
bCI55+uQYaiahyU0Y1CAx7dtho1RQW0FV4VFPmCe0SldOM+U69sOJYTYBVjHnZc7
9fkmkPAIBGKhbFDBjVvCGajrfD0qSg/HX27sEao4UQ==
=hyt1
-----END PGP SIGNATURE-----

--SMcH7s1wxTzO87UA--


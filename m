Date: Fri, 15 May 2020 22:46:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200515204626.GO1431@...1296...>
References: <CALVjyqoi3ZkOn2p+2i=xBS_pNHKbym0eReWCWHAg9+-ULwtEgQ@...278...>
 <CALVjyqo5NNddn3E+cV_eAySc1VzYeLXPvvKUykOusaZF9LhjxQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/fRlZZYwA1+ilXGw"
Content-Disposition: inline
In-Reply-To: <CALVjyqo5NNddn3E+cV_eAySc1VzYeLXPvvKUykOusaZF9LhjxQ@...278...>
Subject: Re: [Openvpn-devel] deferred client-connect -
 https://patchwork.openvpn.net/patch/607/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Shreyas Heranjal <mailshreyas@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--/fRlZZYwA1+ilXGw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 15, 2020 at 12:40:08PM -0700, Shreyas Heranjal wrote:
> > I want to use client-connect plugin to assign IP addresses to the clien=
ts,
> > and I want to do it asynchronously through my IPAM service. I was going
> > through the openvpn-devel forum and found this patch.
> > https://patchwork.openvpn.net/patch/607/
> >
> > Is this patch safe to use? Any reason why this was not included in the
> > latest version of Openvpn?

It's being worked on.  The patchset is fairly large and has not been
reviewed fully (and initial review turned up the wish for some
restructuring).

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/fRlZZYwA1+ilXGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJevv+iAAoJEB2Cnv7KVigSj6sMAIL9+MpAMMUvY4dfo1ztbMqL
AzZ+tZUJyTkB1BjngUG+aDaa64nmDnZYtvamRUNLAXm7Vy+cFqxW2Yp6MfNBrjWH
mAWbzVsvo9WOsc778u4nC5Nbgy0fmBbgPnazf6xOU07BPlJFCD+aPVqwULDQtZiz
wJc2i742LoCiHoi3p0s6qsZ2H9yui4KUnCF1PvzqK3iRcOxX/kyHyoYhhFmtICeu
TuzSrjyXHnSMRwRIZxfp/RDZhC3pp1NPNAvrQoCYwTgNjnOycrdIQqYSA4We+Tpq
N0kV5AJzn7E/Ofg3S8+Hq0+Dcbf3zSy2CDB9cuKAMERea6OGVJOSl/iUQJKRisTm
2wuzE+l+nRppxLkBOue2zk7ccPXWSdGi14i9SOUu+jvIuh058X3VWuccsyEIz4t8
C2neYSdTzXD+rKRTa17kFgLuH+soa5EYA59kUE0iWsNRwFjaNhJo0hzVKlLun5eI
2dGJVJuArGY/gtComGCFE41KbKFc7rZz9F+g+DI26w==
=Y27f
-----END PGP SIGNATURE-----

--/fRlZZYwA1+ilXGw--


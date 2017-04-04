Date: Tue, 4 Apr 2017 08:45:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170404064534.GC93896@...1296...>
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3tHEeV7QUZcH1cKB"
Content-Disposition: inline
In-Reply-To: <53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
Subject: Re: [Openvpn-devel] [PATCH] Add per session pseudo-random component
 to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

--3tHEeV7QUZcH1cKB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 04, 2017 at 08:29:49AM +0200, Simon Matter wrote:
> Interesting to see that there is zero interest in this patch here.

This is a misinterpretation.

If you monitor the list, it has been fairly quiet since 2.4.0 release -=20
the active core of openvpn developers have all been busy with other
things for one or the other reason, so progress on all fronts has been
slow, and response times could be much better.

I think this is a useful addition, but didn't have time to really think
through the code changes yet (=3D review), so I didn't say anything.  I know
Steffan is busy with OpenSSL 1.1 plus paid-for work, David is busy with
other important business.  So it might take a bit.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3tHEeV7QUZcH1cKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY40EOAAoJEB2Cnv7KVigSPNgL/18cUUYdaexs7JOCPbsQsxXz
Li1L/1sho3TappB0JuBsiE8LtJxJtwSdwwQOVeFcdIDKs4LYnD1sZFqRsD54diri
QXXs8fAaUndb/3ITt/AW2qi8qlTPUz0Gl+3cUPg7XJeLiLBGliFzfgao5putQ3We
yW+H3qud4ivlXIpfE06pg7nY8ZYGiiU9Ip1XWlTspMELTG7q4x/rtLaKNi9AK6Zg
IIk5THy/ahMyaUfZKnNmgMx2rJR41x6XnVitTqtWPAlIKekkiRqiMBvpMZJdTDzL
/wIePT8RC5n6AD+P/uPotLgpEUY0IQgZlkh56+QrKEHbhM5I7avAaykwy7zL5xCo
qVK9GgQdbEi20893WKR2X80l00X46Urc/SMnCNVJz6q7dwNrT9uIho/whHlxNLdv
PKxnl8hnAOixM0m4UZIekF8/B6K041hetvPtEIYOPrrq/f8Kz1U5ez698CTinScS
ClvBa4333hE8cob60tneGsGenO0vKWNksm0MPC69Eg==
=HGsA
-----END PGP SIGNATURE-----

--3tHEeV7QUZcH1cKB--


Date: Mon, 28 Aug 2017 11:25:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170828092507.GT70062@...1296...>
References: <CAFHpkQHXhe4UBAePJQXkBYJ+Sahc-3XpVPfPBo5oT6EKbzm3mA@...278...>
 <b524e527-9881-1e25-2ba0-fd7e4117afc4@...1856...>
 <CAFHpkQHbGSsU7gsRcogr+7JzpDXoBd9r669cOpRxp1k8h91Smg@...278...>
 <0526aa24-77dd-7901-a9c9-1287648fcf9a@...2080...>
 <0ab532b3-fdf2-7dcd-b125-42ccedb2e843@...1294...>
 <bb618b3b-42d2-9610-72b3-d7c7e5691e97@...277...>
 <dc75ad56-7bce-9316-ed40-541947306368@...1294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0FDNE3+7N8PCoNAN"
Content-Disposition: inline
In-Reply-To: <dc75ad56-7bce-9316-ed40-541947306368@...1294...>
Subject: Re: [Openvpn-devel] [Openvpn-users] explicit-exit-notify is ignored
 by previous <connection> blocks.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eike Lohmann <e.lohmann@...1294...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--0FDNE3+7N8PCoNAN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(copying in openvpn-devel as the author of the offending patch is not
reading -users)

On Mon, Aug 28, 2017 at 09:50:12AM +0200, Eike Lohmann wrote:
> > I believe this simply infers that 'previous' <connection> "blocks" will=
 not be
> > effected by this _pushed_ option.
> >
> > It is a very dodgy message none the less ..
>=20
> Yes, I also think so.

Indeed, it shouldn't print the <connection> message for pushed options
- though I'm not sure why it does - or, phrased differently, why nobody
else has stumbled across this when the corresponding change has been
in-tree since December 2013...

Author: Arne Schwabe <arne@...1227...>
Date:   Tue Dec 17 11:22:47 2013 +0100

    Add warning for using connection block variables after connection blocks
=20=20=20=20
    In 2.3  some options that were allowed only in global config before have
    been moved to connection blocks. This changes the behaviour if the
    variables were defined after connection block. This patch adds a warning
    to catch these mistakes.


Could you throw a log that shows what the server pushes and then the
warning message (plus the client config, stripped of all sensitive stuff,
of course) into our trac?  Then it won't get lost and we can go and
investigate...

The option parser is a big chunk of magic, so it's possible that some
extra conditions need to be checked before printing the message...

thanks,

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0FDNE3+7N8PCoNAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZo+FyAAoJEB2Cnv7KVigSDqcL/Rzbxy4TLpGPlqBVyO85nHU2
EqBnVApCKkeqPyQvYJtG0I25CQRma98ODpP104eHHRln+I0Gbm7H/3QCyiLOoZ8B
kVUn9PmgNUznDPkzLxRxhuLPiqsZYvipGggQtOebHqDY+jjYj2mCvQxtayaY0R6g
AfQ4DjdglE3yMa1GLy8/ANRi2fNZgFd8yCGGuqR2f5K1E4234ynGxZI0URJlX8yu
jMxnnEU9z19t3vUvvjTo9RfRysNxK1UHNHyQQFejLcqAIU6mOml6k7xPT6w2VmNy
+dORLmwUg49WKk7ALIXzR0whhSongcztYK+j6gtGfR38GxSrGL0+yglVs6tLSpy3
rFG8v9QVEpKRdEnaamo4MakafAGvXQzJmfbR3sEySsdFPiMhhB7JwbMRFhGkhE97
2/R1zosEaercERtGxj3zOdTyirZbsNWpJDuFj3QxP0vXT/WoD+vc+iRh39080jxE
3PGiRBhaAnraJPHodwKVYfrBFf4Q08I5VBOCGyXE6A==
=hV3H
-----END PGP SIGNATURE-----

--0FDNE3+7N8PCoNAN--


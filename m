Date: Sun, 15 Feb 2015 23:01:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150215220144.GP8134@...1296...>
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FcqbpLOAFGOf/VCz"
Content-Disposition: inline
In-Reply-To: <54E10A03.3000400@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--FcqbpLOAFGOf/VCz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 15, 2015 at 10:05:07PM +0100, Arne Schwabe wrote:
> Am 24.01.15 um 18:04 schrieb Vasily Kulikov:
[..]
> > OpenVPN itself gets new 'NEED-CERTIFICATE" command which is called when
> > --management-external-cert is used.  It is implemented as a multiline
> > command very similar to an existing 'RSA-SIGN' command.
> >
> > The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.
> ACK from me to the OpenVPN part. I also tested the patch in OpenVPN for
> Android and the RSA-SIGN still works as expected. I have not reviewed
> the OS X contrib program (other than a quick glance at the code) but I
> think marking it as contrib it should be allowed to be still included.

I hear Arne, and James also ACKed this ("based on testing", which Arne
did).

I'm not merging it yet, though - Vasily, please provide a v4 of the patch
that adds:

 - documentation of --management-external-cert in doc/openvpn.8
 - documentation of the new management command and response in=20
   doc/management-notes.txt
 - fix the typos in the options here (please fix the other one, too):

@@ -2221,6 +2230,8 @@ options_postprocess_verify_ce (const struct options *=
optio
ns, const struct conne
 #ifdef MANAGMENT_EXTERNAL_KEY
           if (options->management_flags & MF_EXTERNAL_KEY)
            msg(M_USAGE, "Parameter --external-management-key cannot be use=
d whe
n --pkcs12 is also specified.");=20
+          if (options->management_flags & MF_EXTERNAL_CERT)
+           msg(M_USAGE, "Parameter --external-management-cert cannot be us=
ed wh
en --pkcs12 is also specified.");
 #endif
 #endif
         }

... it's "--management-external-*", not "--external-management-*".

With that, I'll merge right away :-)

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FcqbpLOAFGOf/VCz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVOEXSKkuBuNlUUl1AQKgagQAvSHUoOTghYkFitsiauzEo7+R+8Ul77pG
QLTdWo/Q4DAGcM/PAHc+Jkkxb+AXfEerpMtFH/+wtgBk7sMkxezsT73UCe4ifYC8
aLq2Y4z6LO19cC67103s9UGr96cmHL02Z0BPBh2T4GJyu7LIOv+bua1cMwfSqMPm
+P8tpg458ZU=
=ALvS
-----END PGP SIGNATURE-----

--FcqbpLOAFGOf/VCz--


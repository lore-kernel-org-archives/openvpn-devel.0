Date: Fri, 8 Sep 2017 09:01:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170908070106.GQ70062@...1296...>
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
 <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
 <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fJz81ohldq3XijGc"
Content-Disposition: inline
In-Reply-To: <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: fragmentux <fragmentux@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--fJz81ohldq3XijGc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 10:02:08PM +0100, fragmentux wrote:
> all your comment are totally valid from a sys-admin point of view but
> from an openvpn POV, the only responsibility is to provide a secure VPN.

Uh, no.  Part of our responsibility is also to provide a reasonably good
experience to sysadmins installing and running openvpn - and if we can
provide a systemd unit file that does "the right thing" for "most of the
time", users will be happier.

(I do not always agree with David on what the best approach to "good
experience" is, so you'll see discussions - but we *do* agree on the
general principle "it should work and not annoy users or sysadmins")

Another example: why do we bother to have warnings about option combinations
that will not work right in our code, instead of "just exit(1) with no
further explanation"?  Because "secure VPN" alone isn't good enought, it
needs to be reasonably robust against misuse, and *tell* users what is
wrong so they can fix their errors.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fJz81ohldq3XijGc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZskAyAAoJEB2Cnv7KVigSGYML/RPZjRx5sMts1wPlS93otMMC
FSN1LVpRv8AmnGTXWfMKxz0pwh3aMpO+jBpzw9Tx3TqlEgiiKdB3LVCpELPxpDTx
UTthdD7Yp0HhlPKjxUY1YM7Dfsa1YRKnrm02eWEqWIuLZ8J5S1UKKAilSGG+m7VC
05CzwtmqAudxJhwSSHVc5WxLmK3MaKkllq9DeRsf42ehB9IzCp6cltWeNMmQ3s+A
bwyBBBoC8Emo0Dqiv3VrvygGjy//erZcEiiTLvq/xM3+peH8p+izJ+8xxGtzT/Ku
OtpzYk4juijBNSNFOmPcHC9TbTWrIlI9Rbv7XHbvlJjmaaBZHPXMo61pOJwL8IXF
97zINbC9FVHO7Vw1YSWMjug4uge/jLCXv888qamRxQwJE3aC/dDg8WSkwcRJ4m9I
qNN/oX78jGcJh4xIuZczUIBO3Q3pJRedXSJTs0Bh7kw43pbCL3WetlUksixZBLYy
SDj4U+TACzikA6bgAr/9Zq70urdaioAFzcbmofG80Q==
=G3yc
-----END PGP SIGNATURE-----

--fJz81ohldq3XijGc--


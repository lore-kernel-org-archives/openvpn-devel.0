MIME-version: 1.0
Date: Thu, 01 Jul 2010 17:28:55 +0200
From: Till Maas <opensource@...519...>
Message-id: <20100701152855.GJ4340@...1276...>
References: <4C2B07C1.9050500@...515...>
	<20100701145951.GI4340@...1276...>
	<4C2CB283.4000408@...1114...>
Content-type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary=g4MvFqI7wmANiPDo
Content-disposition: inline
In-reply-to: <4C2CB283.4000408@...1114...>
Subject: Re: [Openvpn-devel] Packaging OpenVPN for various platforms?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, Steven Pritchard <steve@...610...>

--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 01, 2010 at 05:21:39PM +0200, David Sommerseth wrote:

> But, I do see one big advantage of building packages via Koji (Fedora's
> building system which uses mock), if possible.  That will put these
> packages into a yum repository almost instantly, which can be useful to
> make the packages more easily available.

Using koji is a bit of overkill. There is a small perl wrapper that can
be used to easily build a src.rpm for different archs and distributions
called smock:

http://git.annexia.org/?p=fedora-mingw.git;a=history;f=smock;hb=966f55f8692da3f842da077e57c22ff501e380e1

It also creates yum repos with the resulting RPMs.

Regards
Till

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJMLLQzAAoJEGo6ELMcEJUX0nMQAIh+CgZRYWJMKQ2IjR85VmZq
i8IoUQmCWej4nzmAOBmFbZleaZHXPJusB3D2mRRflVY7EPgjIm7OGDz13ZRyOZPI
KV3DBq9Den7qUwbPiRD5r6TlvojmdU9CU/ZROtlGJzL1aEb4+zELDMTxugd+LfUW
zWA/HWiHps36tQ6wNJey0Id6b9vUKPjKh6d/ah8glchz8VoRVmvJFjaY9hf+CfR0
70gP82BjYY0QSvEqsP006VbaDOqPmE8RqDheHOAfVuGJiOAF4hs+HXupo+PqsBRc
I1y2b9M9f464wHiqEtb4gC/OYMmIZyKNt3b3z0Z+TPc5azckYlgPEMESmIxxVQ0c
laj5cjXwKXGkp09TFsG2Hi18yQPbFwQHLDagZz0bgn+ps5L8LofeFbHSVSJXIJTw
AZKZ5FOp1zK4pmjxcNAoDneFZXJGzBj9thgBQgH4gUO3QF7+ehfqacgwZkKg0xr6
1Esm8p5K7Lbaz5y9SMDhzPBFToL90ozQil41sw4ZnSiBVYAgaC4ipKpSOcbcUOCG
VaxUrjv4xm6HT3tpKXsvRI7KbdmsL2JFI1FAWiFVnS5FGGoutKYnR6jpjK8vQTMo
CktAIE1CZe85CiMfJeJ9Qysjj7Wi6mYP0rcutIodyZP7WVq105K54rMYYBJpsVgn
Onw0RC2ZZW778CWKjWod
=iNQl
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--



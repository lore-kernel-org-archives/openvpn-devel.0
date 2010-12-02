From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 2 Dec 2010 10:59:43 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE713B1@...1436...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
	<4CF76B01.5020308@...193...>
In-Reply-To: <4CF76B01.5020308@...193...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
 patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Farkas Levente <lfarkas@...193...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

PolarSSL was a personal choice for us, mostly due to its simplicity and mul=
ti-platform support. The patch is written in such a way that generic operat=
ions from most libraries should work, as long as a new backend is written f=
or them.

Adriaan=20

> -----Original Message-----
> From: Farkas Levente [mailto:lfarkas@...193...]
> Sent: donderdag 2 december 2010 10:47
> To: Adriaan de Jong
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
> patches
>=20
> On 12/02/2010 10:05 AM, Adriaan de Jong wrote:
> > Hi List,
> >
> > We've been working on OpenVPN in preparation for a security
> evaluation. This entailed documenting OpenVPN at a relatively high
> level, removing the dependencies on OpenSSL, and adding support for a
> simpler, easier to evaluate library (PolarSSL).
> >
> > This was done in a series of patches:
> > - Patch 1: Adds documentation to OpenVPN through Doxygen.
> > - Patch 2: Splits out OpenSSL-specific code, defining a clean
> "backend" interface for both the crypto and SSL modules. Splits the SSL
> module into channel setup and verification sub-modules.
> > - Patch 3: Adds a backend for PolarSSL.
> >
> > We'd love to release these patches to the community. Unfortunately,
> the patches are now based on 2.1.4, and need to be rebased to a newer
> version. Before we spend time on updating the patches to the current
> revision of OpenVPN, we'd like to know whether there is an interest in
> these patches from the community.
>=20
> most distro switch from openssl to nss. is there any reason you switch
> to polarssl in stead of nss?
>=20
> --
>   Levente                               "Si vis pacem para bellum!"


References: <586339C7.2606.801611@...2224...>
	<940951cb-b3e9-f2e9-dea8-43a848bce446@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <24731067-31ff-877d-55f6-e26afc7cc411@...1227...>
Date: Thu, 29 Dec 2016 11:08:40 +0000
MIME-Version: 1.0
In-Reply-To: <940951cb-b3e9-f2e9-dea8-43a848bce446@...515...>
Subject: Re: [Openvpn-devel] Fwd: Re: [Openvpn-announce] OpenVPN 2.4.0
 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 29.12.16 um 10:53 schrieb Samuli Sepp=E4nen:
> Hi,
>=20
> Any comments about the forwarded email? Is our documentation regarding=20
> "or-highest" correct?
>=20

Yes should be correct. Speciyfing a not yet supported tls version, e.g.
"1.3" will also give an error.

Also this directive is not for being always bumped to the next version
but (as tls-version-max) but to exclude certain version, i.e. 1.0.

Arne



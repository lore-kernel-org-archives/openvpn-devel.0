Date: Thu, 02 Dec 2010 12:10:31 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <AANLkTik4eydtMdKm7un1cbf6YvLUQi70OxjXaimqELR8@...278...>
	<AANLkTimTVn5xMKhr-jo5eF3Q2dJpGVDQmVanE9_kmyi9@...278...>
	<4CF7DDE8.8090801@...515...>
In-Reply-To: <4CF7DDE8.8090801@...515...> (from samuli@...515... on Thu
	Dec  2 11:56:56 2010)
Message-Id: <1291313431.25805.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PATCH: floating-tls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Samuli =?iso-8859-1?q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/02/2010 11:56:56 AM, Samuli Sepp=E4nen wrote:
> Hi Blaise,
>=20
> Actually we discussed the floating-tls patch in last community
> meeting:
>=20
> <http://thread.gmane.org/gmane.network.openvpn.devel/4189>
>=20

The discussion ends with deciding that the feature be
"opt-in", I presume via a compile time option.
Why isn't it "opt-in" if enabled with a runtime command line
flag?  If you don't use the flag why should the
resulting session be any less secure?

I have no problem having to enable a compile time
flag for new feature testing, and then having
the flag default to "on" in a later release.
Is that what we're taking about here?


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein



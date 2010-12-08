Message-ID: <4CFF9CE0.7020900@...68...>
Date: Wed, 08 Dec 2010 15:57:36 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C60@...1436...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C64@...1436...>
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C64@...1436...>
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL PKCS #11 Support
 Preview [8/8]
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
To: openvpn-devel@lists.sourceforge.net

Am 08.12.2010 15:33, schrieb Adriaan de Jong:
> Manually adding patches is such a joy=85 =BC failure rate.

Hi Adriaan,

you can use git format-patch and git send-email. Be sure to state the base
revision you've diffed against, just in case git am fails due to intermedia=
te
patches.

HTH - feel free to ask details if you can't get to terms with the Git tutor=
ials
or my comments.

Best regards

--=20
Matthias Andree


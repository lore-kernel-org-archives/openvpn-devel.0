References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <95391fd4-7b2f-389c-3752-4123d016286d@...68...>
Date: Fri, 14 Oct 2016 21:13:04 +0200
MIME-Version: 1.0
In-Reply-To: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
 releases?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 14.10.2016 um 17:28 schrieb Samuli Sepp=E4nen:
> Hi,
>
> Should we have a separate apt repository for "unstable" apt packages?=20
> Right now our apt repositories hold 2.3.x packages, meaning that=20
> upgrades have historically been fairly minor.
>
> That said, users who use _our_ apt repositories have expressed interest=20
> in using something newer than what is available in their distribution's=20
> repositories.
>
> Would 2.3.12 -> 2.4-alpha1 be too big an upgrade?
>
Yes, definitely. Please create a separate distribution for .deb packages
derived from pre-releases.



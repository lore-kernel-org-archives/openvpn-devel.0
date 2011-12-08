MIME-Version: 1.0
In-Reply-To: <4EE0EDA4.2090704@...1338...>
References: <d3f7c10b2411aa41afce3788970ca839@...1528...>
	<4EE08E3A.7010209@...1114...>
	<CAOazyz1MCx8x42YK6-fQs0iAzDS0kRLvZ1sw4hvmcZ4gikJrUA@...278...>
	<4EE0EDA4.2090704@...1338...>
Date: Thu, 8 Dec 2011 22:17:22 +0200
Message-ID: <CAOazyz1P=BhFXogEXUpqqEfrm-UadW1zet8vZpNZBAOm6y5_Eg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add option to disable priority tagged
 packets (VID=0)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: davids@...1347..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, Dec 8, 2011 at 7:02 PM, Fabian Knittel <fabian.knittel@...1338...> =
wrote:
> Am 08.12.2011 11:27, schrieb Alon Bar-Lev:
>> Missing usage, man.
>
> There are probably not *that* many users, agreed. =C2=A0It's probably mor=
e of
> a "large enterprise" feature, as only people with VLAN tagged networks
> would be interested. =C2=A0For example, our university is very fond of la=
yer
> 2 networking and therefore uses VLAN tagging extensively. =C2=A0OpenVPN w=
ith
> VLAN tagging provides a perfect match, allowing a single VPN entry point
> for access to all the different layer2 networks. =C2=A0I imagine that oth=
er
> large organisations could make use of this feature too.
>
> So the number of deployments using the feature will probably never be
> high. =C2=A0But the number of users depending on it, might not be as
> insignificant. =C2=A0The two main deployments at our Uni (currently both =
in
> public beta) currently have about 100 unique users with several thousand
> potential users.

I fail to understand why this is relevant as far as usage (openvpn --help) =
and
manual (man openvpn) to document this.

Alon.


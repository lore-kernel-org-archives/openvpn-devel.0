From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Feb 2012 08:33:59 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOazyz1buhSdSF7g6MzePAiQ=irD_Qo-RKPC_jXoR9AVqbtkvQ@...278...>
	<CAOBzU4P0SxY-jF7rb_HsvmtSH8i9PCk+qe5iDQiwJhajsBuYuw@...278...>
	<CAOazyz1naScdf+M0pnePS6-bb5deAHsAniTiv+DFw3ZQdAN+kg@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
In-Reply-To: <CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
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
To: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> Sent: donderdag 23 februari 2012 21:20
>=20
> Hello Again,
>=20
> Now the openvpn-build supports creating nsis installation package,
> including singing. Output package is at[1].
>=20
> Notice that all process is done on Linux, Windows is not need to create
> the package!
>=20

Hi Alon,

Good news! Overall that sounds great, I do have a few minor details to bick=
er about.=20

> The process:
> 1. Create binaries using openvpn-build/generic.

Could you explain how signing works here? I'm interested in how it's done o=
n Linux.=20

> 2. Create tarball for easyrsa from master (temporary) files should be
> at easy-rsa-2.0.

Is that a tarball or a zip file? The latter might be easier for Windows use=
rs.

> 3. Create the installer using openvpn-build/windows-nsis.
>=20
> I did not add the UI stuff, I think there should be a discussion why
> these are embedded.
>=20

One of the few pieces criticism we got about the OpenVPN-NL release was the=
 fact that we didn't bundle the GUI. End-users expect an all-in-one install=
er for a simple user experience. As an end user of OpenVPN, I agree. On Win=
dows, I don't want to use the command line, as it is very painful.


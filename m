Date: Tue, 21 Feb 2012 16:54:44 +0100 (CET)
From: g.esp@...260...
Message-ID: <6d72447b-01a4-4a16-ac04-6a65b0c3fbdc@...1545...>
In-Reply-To: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>



----- Mail original -----
> De: "Alon Bar-Lev" <alon.barlev@...277...>
> =C3=80: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@...1659...=
forge.net>
> Envoy=C3=A9: Mardi 21 F=C3=A9vrier 2012 16:15:22
> Objet: [Openvpn-devel] [RFC] openssl minimum supported version
>
> Hello,
>
> OpenVPN supports minimum openssl version of 0.9.6, while this version
> is unsupported by upstream and probably a security risk.
>
> What would be a suitable minimum version to support?
>
> I think that 0.9.8 is the one.
>
> Regards,
> Alon.
>

I confirm openssl no more maintain 0.9.7 version.
RHEL-4 will reach end of life support at february end and use 0.9.7.
So supporting 0.9.8 as the last version make sense.

Gilles


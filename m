Message-ID: <496B97F9.1020504@...349...>
Date: Mon, 12 Jan 2009 19:20:25 +0000
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
References: <496B7A61.6090602@...260...>
	<9e0cf0bf0901120958n4ea62c57s991e8a6e0335fbbd@...278...>
In-Reply-To: <9e0cf0bf0901120958n4ea62c57s991e8a6e0335fbbd@...278...>
Subject: Re: [Openvpn-devel] [patch] enhance tls-verify possibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

Alon Bar-Lev a =E9crit :
> Thank you for the patch.
> I am more in favor of adding OCSP support into OpenVPN.
> It should be very easy using OpenSSL trunk.
> Also available at [1].
> So if you can help perfecting this patch it would be a step in the
> right direction.
> [1] http://www.block64.net/

I think it is not as flexible as the Mathieu's patch.

For example, a certificate or a CA can provide it's own "Authority
Information Access" (via a x509 extension) with the URL of a prefered
OCSP server... Manage this kind of configuration inside OpenVPN is not
easy.

The "--tls-export-cert" option (proposed by Mathieu) put the complexity
in a script, where you are only limited by your imagination : OCSP is an
example, but you can also think about OSCP with fallback, SCVP,
revocation with delta CRLs, check against a NSS database, etc. Think
about blacklists, too...

We can not integrate all these cases directly in OpenVPN. An external
system (as for all others scripts in OpenVPN) provides an very efficient
solution.

Just my 2 cents..
--=20
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Administration des ressources informatiques
Agence universitaire de la Francophonie (AUF)


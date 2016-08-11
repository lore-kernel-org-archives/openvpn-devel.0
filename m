References: <CAAWBBYOc5H=0X7b=i_gizvTZUDv2RwxQUEOY85P6c3z-y_U8og@...278...>
	<3e7224ae-474c-1cfd-7bcf-3b9eeb14cb7a@...1227...>
	<CAAWBBYO9jbqR8rv_rTEAhEUsG90Okffor1j3o7XuPXDdxw9Hug@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3c089368-5bea-6960-fc4e-aed2a948c1af@...2080...>
Date: Thu, 11 Aug 2016 18:29:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAAWBBYO9jbqR8rv_rTEAhEUsG90Okffor1j3o7XuPXDdxw9Hug@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Added client-ip option to NAT
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Rafael Gava <gava100@...277...>, Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/07/16 13:53, Rafael Gava wrote:
[...snip...]
> Your request not to use 'localhost' is ok.  So I changed
> 'client-ip'. But since we have so many clients already configured
> with the 'localhost' keyword, we would like to gradually make the
> transition.  We would like to have 'localhost' be an undocumented
> alias to 'client-ip', at least until we have made the transition.

NAK.  We do not want any extra undocumented keywords in upstream
OpenVPN; we already have enough of them and we're still discovering
new undocumented features every now and then.

If you already have put this into production (great! well tested
patches are always a good starting point) and already depends on
'localhost' for you users, you need carry that support/maintenance
burden for this keyword with your user base on your own.

When (If?) your patch with 'client-ip' only gets an ACK, then the
additional patch you will need to carry in addition should be minimal
and can be removed once all your users and servers have updated
configurations.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlesp9EACgkQDC186MBRfroFmACggWoN0qvc85Qhz1kW+6iVD9AD
jDYAnRJGVQGWqcSY3kZbt+O6hv5fDWbr
=3DQS/M
-----END PGP SIGNATURE-----


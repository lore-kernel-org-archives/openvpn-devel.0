From: Heiko Hund <hhund@...194...>
Date: Fri, 5 Mar 2010 09:42:23 +0100
References: <20100228145001.GM9556@...1296...>
In-Reply-To: <20100228145001.GM9556@...1296...>
MIME-Version: 1.0
Message-Id: <201003050942.23706.hhund@...194...>
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi Gert,

On Sunday 28 February 2010 15:50:01 Gert Doering wrote:
> Now, for all operatings systems *except* Win32 and OpenBSD, the sequence
> of execution is
>=20
>  open_tun()
>  do_ifconfig()

That seems to make sense for OpenBSD. I just had a colleague (kudos Moritz)=
=20
try to connect with ifconfig_order() changed to

 static inline int
 ifconfig_order(void)
 {
 #if defined(WIN32)
   return IFCONFIG_BEFORE_TUN_OPEN;
 #else
   return IFCONFIG_AFTER_TUN_OPEN;
 #endif
 }

and it broke the tunnel.

Regards
Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Executive Board: Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nelli=
ssen
Chairman of the Supervisory Board: Stanley J. Krasnow
Headquarter Location: Karlsruhe
Commercial Register: Mannheim HRB 108997


Message-Id: <200411100915.iAA9FINl006025@...309...>
In-Reply-To: Your message of "Wed, 10 Nov 2004 01:03:35 +0100."
             <20041110000335.GB17347@...307...> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-872148448P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
From: George Ross <gdmr@...308...>
Subject: [Openvpn-devel] Re: [Openvpn-users] IANA has approved a unique port number for OpenVPN
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Nov 10 01:16:05 2004
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--==_Exmh_-872148448P
Content-Type: text/plain; charset=us-ascii

> > I'd be inclined to make the change before 2.0 final is released.  Any other
> > opinions?
> 
> Can the server support listening on two ports at the same time? This
> would make migration much easier.

Hear hear.  (Actually, it would be really useful if it could listen on TCP 
and UDP at the same time too...  I imagine it wouldn't be much harder to 
put in fully general port/protocol handling than it would be to put in a 
special case to support just two combinations at a time.)
-- 
Dr George D M Ross, School of Informatics, University of Edinburgh
    Kings Buildings, Mayfield Road, Edinburgh, Scotland, EH9 3JZ
Mail: gdmr@...308...   Voice: +44 131 650 5147   Fax: +44 131 667 7209
 PGP: 1024D/AD758CC5  B91E D430 1E0D 5883 EF6A  426C B676 5C2B AD75 8CC5



--==_Exmh_-872148448P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.6.3 2003/04/04

iD8DBQFBkdwmtnZcK611jMURAkuQAKCtVVInQmMvoUzUElxxAADsXgpLoQCePo9O
lZlqTPdvWbAF7Kj2A53428Y=
=S/Yh
-----END PGP SIGNATURE-----

--==_Exmh_-872148448P--


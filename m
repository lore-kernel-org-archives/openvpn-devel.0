From: Torge Szczepanek <openvpn-devel@...239...>
Subject: Re: [Openvpn-devel] Urgent: Limitation to 100  virtual tunnel devices??
References: <OF16152585.163DBB30-ON41256EC4.0055E643@...246...>
In-Reply-To: <OF16152585.163DBB30-ON41256EC4.0055E643@...246...>
MIME-Version: 1.0
Message-Id: <200407011903.15901.openvpn-devel@...239...>
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
Date: Thu Jul  1 10:04:07 2004
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 01 July 2004 18:18, Juerg.VonBueren@...245... wrote:

> Is there any known Limitation to 100 TUN-Devices or how can we break that
> limitation?

This is a limitation in the Linux kernel code not in OpenVPN.

The limitation is in net/core/dev.c

You can change this by modifying the value and kernel recompile.

See in net/core/dev.c:

- --------------

        /*
         * If you need over 100 please also fix the algorithm...
         */
        for (i =3D 0; i < 100; i++) {
                snprintf(buf,sizeof(buf),name,i);
                if (__dev_get_by_name(buf) =3D=3D NULL) {
                        strcpy(dev->name, buf);
                        return i;
                }
        }
        return -ENFILE; /* Over 100 of the things .. bail out! */
}

- --------------

Note that performance will be bad when going beyond about 200 or 300 device=
s=20
on a modern pc.

It is better to replace the code by a hashed device lookup. I found out tha=
t=20
this is the case in my debian 2.6. kernel. I haven't checked when this was=
=20
introduced and whether this is a debian patch or present in the vanilla=20
kernel code.

I can send you a patch by mail for the 2.4.26 kernel which also should appl=
y=20
back to 2.4.18 or lower. This was written by Ben Greer for VLAN support and=
 I=20
modified it to apply cleanly to 2.4.18 and higher. Linus rejected this patc=
h=20
for the 2.4 series. It works for me on more than 30 servers without any=20
problems.

A linux distro including this patch is Adamantix (www.adamantix.org)

Torge
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5EPSosmtDiD9dbIRAt/uAJ9gI/O6SQX4+XLmJcPtut/KNQEoewCaAlJt
UR6wuo9p1IFCUakA1coyLA4=3D
=3DeOGl
-----END PGP SIGNATURE-----


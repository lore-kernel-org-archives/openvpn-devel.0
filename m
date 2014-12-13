Message-ID: <548C93A3.1050807@...68...>
Date: Sat, 13 Dec 2014 20:29:39 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <546BCC47.5010205@...68...>
In-Reply-To: <546BCC47.5010205@...68...>
Subject: Re: [Openvpn-devel] AES-NI trouble,
	and patch - please review/comment
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

Am 18.11.2014 um 23:46 schrieb Matthias Andree:
> Greetings,
>=20
> I received a bug report against the FreeBSD OpenVPN port, but before
> applying a patch (by Ermal Lu=E7i) I do not currently oversee, I would
> like your input.
>=20
> https://redmine.pfsense.org/issues/3966			 original
> https://community.openvpn.net/openvpn/ticket/480	 copy
> https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D195004 downstream
>=20
> Is this a safe fix, or will it break other features or requirements, in
> the lights of restarts after timeouts, and all that?

Anyone got opinions on this?



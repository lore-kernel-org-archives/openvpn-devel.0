From: Christian Daniel <cd@...154...>
Subject: Re: [Openvpn-devel] OpenVPN + Linux 2.6
References: <twig.1074069340.78328@...41...>
In-Reply-To: <twig.1074069340.78328@...41...>
MIME-Version: 1.0
Message-Id: <200401140958.45556.cd@...154...>
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
Date: Wed Jan 14 00:59:02 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hello James,

I'm using OpenVPN 1.5 with Linux 2.6.1-rc2. So far I can say, that it works=
=20
perfectly. All I had to change was to add "dev-node /dev/misc/net/tun" to t=
he=20
parameters list.
So I think, it would we an idea to add this to the searchpath for the Tun=20
device.

Christian

On Wednesday 14 January 2004 09:35, James Yonan wrote:
> I'm going to be rolling out a new OpenVPN beta shortly, mostly with
> bugfixes.
>
> How are we doing on Linux 2.6?  Any suggested fixes in code or
> documentation to improve usability/compatibility with 2.6?
>
> James
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Perforce Software.
> Perforce is the Fast Software Configuration Management System offering
> advanced branching capabilities and atomic changes on 50+ platforms.
> Free Eval! http://www.perforce.com/perforce/loadprog.html
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--=20
+-------------------------------------------------------+
| Christian Daniel                                      |
| Drechselblick 5        Mariannhillstra=DFe 6 / App. 220 |
| D-97816 Lohr am Main   D-97074 W=FCrzburg               |
+-----------------------+---------------+---------------+
| http://www.cdaniel.de | cd@...154... | ICQ: 95896119 |
+-----------------------+---------------+---------------+



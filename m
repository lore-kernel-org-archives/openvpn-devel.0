Message-ID: <4C288AFD.5070805@...1114...>
Date: Mon, 28 Jun 2010 13:43:57 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C286BBB.7080206@...515...>
In-Reply-To: <4C286BBB.7080206@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (24th Jun 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/06/10 11:30, Samuli Seppänen wrote:

> 
> Discussed an old patch, "Exclude ping and control packets from activity":
> 
> <http://article.gmane.org/gmane.network.openvpn.devel/3690>
> 
> This issue had been discussed in an earlier meeting:
> 
> <http://article.gmane.org/gmane.network.openvpn.devel/3673>
> 
> In this earlier meeting we decided to ask our users if they had managed
> to configure proper byte limit for --inactivity so that the ping traffic
> would be effectively ignored (without side-effects). Unfortunately
> nobody replied:
> 
> <http://article.gmane.org/gmane.network.openvpn.devel/3676/>
> 
> Waldner will test the patch thoroughly to ensure that it never causes
> ping packets to be dropped. After this the patch can be merged into
> "testing" tree.

Just to clarify a little bit ... The testing will confirm that the patch
do not count internal ping traffic between the OpenVPN server and client
as tunnel traffic, and that other types of traffic (tunnelled traffic)
is accounted for correctly - and that no tunnelled or other internal
control traffic is dropped due to this patch.

The problem in current releases is that the --inactivity feature do not
stop the client if there going a certain amount of ping traffic between
server and client when using the --ping or --keepalive features.  The
assumption is that the provided patch will fix this.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwoivgACgkQDC186MBRfronbQCfSY7ZWhjEs9bXB0RruqERHk6T
r2UAn3oECN697qMB60NAeO6dhBBGCUTY
=g5UX
-----END PGP SIGNATURE-----


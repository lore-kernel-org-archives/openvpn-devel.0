From: Heiko Hund <hhund@...194...>
Date: Fri, 3 Sep 2010 08:51:03 +0200
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
In-Reply-To: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
MIME-Version: 1.0
Message-Id: <201009030851.28881.hhund@...194...>
Subject: Re: [Openvpn-devel] My results of OpenVPN Benchmarking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi Ansis,

On Thursday 26 August 2010 19:56:56 Ansis Atteka wrote:
> 4. During a OpenVPN 1200 client bomb test I observed that OpenVPN stalled
> with 100% CPU. In the openvpn log I saw that there are too many opened
> files (output of "ls /proc/PID/fd | wc -l" showed that there were 1027
> opened files). The bad thing is that killing all those 1200 clients did
> not help the OpenVPN server to recover and it remained in stall state. It
> looks like a bug for me.

If you used --proto tcp it probably just were the connected sockets.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


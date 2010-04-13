From: Heiko Hund <hhund@...194...>
Date: Tue, 13 Apr 2010 16:56:45 +0200
References: <1269951178-30419-1-git-send-email-dazo@...384...>
	<t2o9e0cf0bf1004130659l5c4a8dc2o6eab22db336078be@...278...>
	<4BC48199.4060600@...1114...>
In-Reply-To: <4BC48199.4060600@...1114...>
MIME-Version: 1.0
Message-Id: <201004131656.45521.hhund@...194...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
	./configure information to --version
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

On Tuesday 13 April 2010 16:37:13 David Sommerseth wrote:
> The config.log is *only* used for getting the command line of how
> ./configure was called, via configure_log.awk.  To my knowledge, this
> information is not available anywhere else.  If I have overseen this
> somewhere, then please enlighten me.

Couldn't that be done in a much cleaner way by just using the $* shell=20
variable?

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Executive Board: Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nelli=
ssen
Chairman of the Supervisory Board: Stanley J. Krasnow
Headquarter Location: Karlsruhe
Commercial Register: Mannheim HRB 108997


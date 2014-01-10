Message-ID: <52D076F9.7060702@...1227...>
Date: Fri, 10 Jan 2014 23:40:57 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1389371142-26705-1-git-send-email-gert@...1296...>
	<1389371142-26705-2-git-send-email-gert@...1296...>
In-Reply-To: <1389371142-26705-2-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Cleanup ir6->netbits handling.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 10.01.14 17:25, schrieb Gert Doering:
> Get rid of all "if (ir6->netbits>=3D0)" checks, as those are always true
> (unlike ir->netbits for IPv4, we don't do the special case for "if it's
> a host, put -1 in there" for IPv6).
>
> Merge mroute_helper_{add,del}_iroute and mroute_helper_{add,del}_iroute6
> into unified mroute_helper_{add,del}_iroute46() function as they did the
> same thing anyway, just with slightly different parameters.
>
> Make Arne happy.
>
>
:)

ACK

Arne



From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Problems with openvpn - restarting 10 sec
References: <405994455@...83...>
In-Reply-To: <405994455@...83...>
MIME-Version: 1.0
Message-Id: <200406241514.55575.vda@...216...>
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
Date: Thu Jun 24 05:16:13 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ullrich Dittmer <uni-webmaster@...83...>, openvpn-devel@lists.sourceforge.net

On Thursday 24 June 2004 12:04, Ullrich Dittmer wrote:
> Hi,
>
> I would like to use openvpn (1.6) to connect my home pc direkt over the
> proxy of my internet service provider (isp). At the server side I startet
> openvpn with
>
> openvpn --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --verb 9 --proto tcp-serv=
er
> --lport 8080 --comp-lzo --link-mtu 296
>
> and on the client:
>
> openvpn --remote luckyluke.homelinux.org --dev tun1 --ifconfig 10.4.0.2
> 10.4.0.1 --verb 9 --http-proxy 195.182.114.52 8080 --proto tcp-client
> --rport 8080 --comp-lzo --link-mtu 296 --redirect-gateway

IP minimum MTU are way more than 296. You are violating IP.
--=20
vda


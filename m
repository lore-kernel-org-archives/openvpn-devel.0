Message-ID: <4918.80.140.145.136.1080387905.squirrel@...190...>
Subject: Re: [Openvpn-devel] Tunnel Problem Linux<->Windows2000
From: "Markus Gsottberger" <ml-lists@...189...>
In-Reply-To: <406496BE.60409@...191...>
References: <1300.212.114.222.10.1080315611.squirrel@...190...>
        <406496BE.60409@...191...>
MIME-Version: 1.0
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
Date: Sat Mar 27 03:46:02 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi David,

>> i'm using OpenVPN 1.5 on Linux and Windows2000 and have a Problem.
>> Ping and traceroute works fine through the tunnel. But wenn i for
>> example try to transfer files it fails after a few kb. Any ideas?
>> My config and the Error Message on the client are below.

> Same thing happened to me. Adding
> tun-mtu 1500
> mssfix 1325
> to the config fixed it.

i added the mssfix and it works like a Charm now, thx!!

-- Markus




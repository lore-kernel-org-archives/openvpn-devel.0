Message-ID: <53BFACDE.9050609@...1227...>
Date: Fri, 11 Jul 2014 11:22:38 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
	<53BFA759.7060307@...1227...> <53BFA9A0.3020605@...1147...>
In-Reply-To: <53BFA9A0.3020605@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net


>
> This is really not *necessary*, but the way the code does tun & tap and
> net30 & subnet, it gets confused about things.  Needs fixing, sorry for
> that.
>
>
>
> so in some cases a server-side statement
>  route 192.168.1.0 255.255.255.0
> works fine with 'topology net30' but NOT with 'topology subnet'.
>
> This is a long standing bug that needs to be fixed before we can
> forcefeed everybody 'topology subnet'.

Okay. I see where the confusion is coming from. if you have net30, the
second parameter for the ifconfig is always the gateway. In subnet you
explicity need to set the gateway by setting/pushing route-gateway.

In normal setups the --server macro automatically does that for you.

I am not really seeing a bug here but a misconfiguration of OpenVPN.
Sure the error messages could be improved and I am all ear to this.

Arne


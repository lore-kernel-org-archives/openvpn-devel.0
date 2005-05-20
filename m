From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Re: Radius support (Authentification,
 Authorization and Accounting)
In-Reply-To: <d6l1bt$uln$1@...165...>
Message-ID: <Pine.LNX.4.58.0505201030360.13685@...41...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...>
 <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...>
 <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...>
 <1116334849.14388.43.camel@...23...> <Pine.LNX.4.58.0505170713570.2777@...41...>
 <1116337185.14388.71.camel@...23...> <Pine.LNX.4.58.0505171009060.2777@...41...>
 <d6l1bt$uln$1@...165...>
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
Date: Fri May 20 09:39:00 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 20 May 2005, Ralf [UTF-8] L=C3=BCbben wrote:

> Hello,
>=20
> I have a big problem with my programm.=20
> I developed it with a test main function with the
> openvpn_plugin_open_v1, openvpn_plugin_func_v1 and openvpn_plugin_close_v1
> function and everything works fine.=20
> I used some c++-libraries and my whole radius stuff is in a c++-class.=20
> When I compile my programm as a shared library with the g++ and use it wi=
th
> OpenVpn I get the following error:
>=20=20
> Fri May 20 17:34:32 2005 us=3D538779 PLUGIN: could not find symbol
> 'openvpn_plugin_open_v1' in plugin shared
> object /root/test/auth-pam.so: /usr/sbin/openvpn: undefined symbol:
> openvpn_plugin_open_v1
>=20
> I think the problem is that I use c++, if I compile with the gcc the
> openvpn_plugin_open_v1 is found and the c++-objects are not fornd.
>=20
> Is it possible to use the c++-classes and my radius classes with shared
> libraries in OpenVpn?
> At the moment I have no idea to solve this.

You can declare C function prototypes in C++ code with

	extern "C" {
	  include "openvpn-plugin.h"
	}

to maintain compatibility between the C and C++ namespaces.

James



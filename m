From: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Message-ID: <d7fjlh$hrc$1@...165...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...> <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...> <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...> <1116334849.14388.43.camel@...23...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Re: Radius support (Authentification, Authorization and Accounting)
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
Date: Mon May 30 10:56:08 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

at the momemt the radius plugin is working. 
The plugin model is very good. It was possible to implement the plugin
without any problems.

I have still one question about the NAS-Port attribute. At the moment the
port number is increment for every user, but never decremt.
Will this be a problem with freeradius? Must the number be in a special
range, maybe for assignment?

I have still another programming question. In the plugin example for pam,
all functions are static functions. Which advantages has the static
function opposite to a "normal" function?

Thank you. 

Ralf Lübben






Subject: Re: [Openvpn-devel] route option deleting routes it didn't set
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1085784020.8700@...41...>
In-Reply-To: <200405282334.29774.vda@...216...>
References: <20040528142953.GG1243@...30...>, <20040528142953.GG1243@...30...>
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
Date: Fri May 28 15:53:29 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Denis Vlasenko <vda@...216...>, Alberto Gonzalez Iniesta <agi@...5...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Denis Vlasenko <vda@...216...> said:

> On Friday 28 May 2004 17:29, Alberto Gonzalez Iniesta wrote:
> > Hi,
> >
> > We got a bug report at Debian [1] regarding the route option.
> > It turns out that if a route added by openvpn is later
> > modified (removed and added to other iface), openvpn will modify
> > (delete) the later one.
> >
> > As the bug submitter states, maybe openvpn should specify the device it
> > wants the route deleted from.
> 
> I think openvpn's routing options are intended for 'typical use' only.
> It is impossible for openvpn to know each and every non-trivial setup
> possible.
> 
> If you modify openvpn-created route after it starts, your setup
> is at least a bit non-typical.

I'd have to agree here that sensing cases where the user modifies the routes
set by OpenVPN through the use of the --route directive is beyond the scope of
what --route is meant to accomplish.  It would be better to just use
--up/--down scripts in this case.

James



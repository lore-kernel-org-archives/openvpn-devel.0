From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] openvpn 1.x: route on darwin
References: <twig.1084557936.3304@...41...>
In-Reply-To: <twig.1084557936.3304@...41...>
MIME-Version: 1.0
Message-Id: <200405151135.03079.vda@...216...>
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
Date: Sat May 15 01:37:02 2004
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, Julien TOUCHE <julien.touche@...61...>, openvpn-devel@lists.sourceforge.net

On Friday 14 May 2004 21:05, James Yonan wrote:
> Right now all new patches are going into 2.0, but I'm certainly amenable to
> merging localized patches such as the route patch for darwin into 1.x.
>
> I will add to the todo list for 1.6.1.

Hmm. On Unixlike systems it typically easier to
call sh script to do this kind of config changes.
This looks like superior solution to me.

For example, udhcpcd (DHCP clent) never ever touches
configuration of eth device it operates over. It
handles _only_ DHCP protocol, and whenever it detects
change in DHCP state (i.e. it obtains/loses a license),
it calls program specified via --script directive.
That program is typically sh script. It can be easily changed
to do whatever needed (routing table changes of arbitrary
complexity, popup windows, ring a bell, whatever).
Without changing udchcd source.

udhcpcd passes all parameters to the script via env,
not command line. It makes it easy to add new parameters
as udhcpcd evolve without breaking existing scripts.
--
vda



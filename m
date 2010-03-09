Date: Tue, 09 Mar 2010 09:58:23 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B96559D.30305@...1114...> (from
	openvpn.list@...1114... on Tue Mar  9 08:05:17 2010)
Message-Id: <1268150303.24740.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

On 03/09/2010 08:05:17 AM, David Sommerseth wrote:

>  On the other hand, ./configure
> could try to detect which DHCP client the system got and could use
> that
> as a default client to kick off.

I think this might cause more problems than it solves because
there's no guarantee that build hosts will have the same,
or any, dhcp client that is ultimately used.   I'm with
Peter Stuge regarding being able to support a choice
of clients, and having the wrong default in place can
just complicate things.

Maybe what makes the most sense from a package
management standpoint is to have the package installation
process autodetect the existing dhcp client so that whatever
the user has installed will be used (once the feature
is turned on with --route-gateway.)  I'm not sure how
to best facilitate this with OpenVPN.  Perhaps OpenVPN
should default to using something like
/etc/openvpn/route-gateway-dhcp-client and then
package installation can softlink that to whatever
dhcp client is installed.=20=20

Over-automating things will cause people headaches.
You don't want to willy-nilly startup a dhcp client
and have all your interfaces configured with dhcp without
your consent.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein



From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2005.06.07.23.25.05.884303@...294...>
References: <1708CC68-CD66-4E56-A729-5E96D2A3F555@...412...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Pushing network settings to Mac OS X clients
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
Date: Tue Jun  7 16:29:03 2005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Wed, 08 Jun 2005 00:53:33 +0200, Ralf Ebert wrote:

> OpenVPN offers the possibility to push "Windows-specific network settings"
> from the server to the client. Pushing a DNS server to the client doesn't
> seem to be Windows specific and would be quite a nice feature for other
> operating systems as well. I'd like to ask if it's intended that this is
> Windows only? I ask because I'd like to work on adding support for this
> under Mac OS X if you give me a starting point for implementing this kind
> of platform specific behavior.

This already can be (and is, on some sites) done. See the foreign_option_*
variables.



Message-ID: <1087085913.40cb9d593793a@...238...>
From: Brandon Knitter <knitterb@...237...>
Subject: Re: [Openvpn-devel] Windows Command Prompt vs. Systray Icon
References: <1087017394.40ca91b21df0c@...238...> <200406130001.48507.vda@...216...>
In-Reply-To: <200406130001.48507.vda@...216...>
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
Date: Sat Jun 12 17:20:44 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Denis Vlasenko <vda@...216...>
Cc: openvpn-devel@lists.sourceforge.net

Quoting Denis Vlasenko <vda@...216...>:

> > I had a few of my users ask why the Windows OpenVPN connection was in a
> > Command Prompt window and not just a Systray Icon with a status window.

> It can be run as a service. It is documented.

I guess this makes sense for the server/gateway side, but I don't think I want
to force my users to have to start and stop a service each time they want to
connect to the office VPN, right-clicking is a pretty cool option for starting
the VPN.  Furthermore, since they still have to enter their password to the
client certificate, I'm not sure how they would be prompted for such as a
service is not really designed to interact with the desktop in such a way.

I can't find the documentation on the service setup, I'll keep searching, but
I'm pretty sure that the service setup is intended for the server/gateway side
of things.

Thanks,
bk





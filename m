Subject: Re: [Openvpn-devel] OpenVPN 2.0 -- Project Update and Release Notes
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1080765010.4445@...41...>
In-Reply-To: <20040331195520.GB24491@...33...>
References: <twig.1080688545.10218@...41...>, <twig.1080688545.10218@...41...>
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
Date: Wed Mar 31 12:34:28 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> On Tue, 30 Mar 2004, James Yonan wrote:
> 
> > OpenVPN 2.0 -- Project Update and Release Notes
> > 
> > I'm happy to announce that the first OpenVPN 2.0 beta is here, and well ahead
> > of schedule.  This is in large part thanks to a generous contribution by
> > Meetrix Inc. which has allowed me to work full-time on the project during the
> > last month.
> 
> In how far does the new OpenVPN 2.0 server require client upgrades?

If you run 2.0 in point-to-point mode (i.e. 1.x behaviour) no client upgrades
are required, with the caveat that some default options have changed.

If you want to use --mode server, then both the client and server need to be
2.0 because the client needs to support the --pull option in order to get
dynamic configuration info from the server.

James



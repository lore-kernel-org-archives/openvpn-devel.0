Subject: Re: [Openvpn-devel] Re: OpenVPN --resolv-retry and --chroot problem
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1067558065.61470@...41...>
In-Reply-To: <1067495953.8347.253.camel@...125...>
References: <twig.1067463490.56118@...41...>, <twig.1067463490.56118@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Oct 30 15:55:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Teemu Kiviniemi <teemuki@...124...>
Cc: openvpn-devel@lists.sourceforge.net

Teemu Kiviniemi <teemuki@...124...> said:

> Wed, 29-10-2003 at 23:38, James Yonan wrote:
> 
> > I would rather see this fix accomplished by adding some kind of dummy call
> > early on in the initialization sequence to trigger the dynamic load of the DNS
> > library -- but which doesn't touch the functionality of the current DNS name
> > resolution code.
> 
> Hi,
> 
> I made a new patch. This time the name lookup is done in openvpn.c if
> options->remote is set, just before entering the chroot jail.
> 
> http://iki.fi/teemuki/openvpn/cvs-resolvfix2.diff
> The patch is against the current CVS version.

Cool -- I merged it.

James



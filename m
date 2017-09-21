Resent-Message-ID: <20170922060007.GF5106@...2038...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Thu, 21 Sep 2017 21:24:13 +0200
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20170921192413.GD5106@...2038...>
References: <20161021154630.GT25148@...2038...>
 <20161021165926.GV25148@...2038...>
 <20161030134825.GB1791@...2038...>
 <792ca4e9-ca51-0764-bd71-a005ac82a9b3@...1227...>
 <20170126140815.GM1074@...2038...>
MIME-Version: 1.0
In-Reply-To: <20170126140815.GM1074@...2038...>
Subject: Re: [Openvpn-devel] [PATCH] Allow to specify bind interface for
 outbound/inbound connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Anno domini 2017 Maximilian Wilhelm scripsit:

Hi,

for the record:

I've updated the PR on github and addressed the issues raised here before.

-> https://github.com/OpenVPN/openvpn/pull/65#issuecomment-330715591

The point remaining is the support for FreeBSD:

[...]
> > > +  if (sock->bind_dev)
> > > +    {
> > > +#if defined(TARGET_LINUX)
> > > +      setsockopt (sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen (sock->bind_dev) + 1);
> > > +#elif defined(TARGET_FREEBSD)
> > > +      setsockopt(fd, SOL_SOCKET, IP_SENDIF, sock->bind_dev, strlen (sock->bind_dev) + 1);
> > > +#endif
> > > +    }
[...]
> > I cannot find that IP_SENDIF in any freebsd man page or /usr/include on
> > a 10.3 system. I don't think this option exists.
> 
> I just googled for this part as I don't have any BSD-ish machines
> here. That part is purely theoretical, that's why I asked for testers :)
> 
> If this turns out to be wrong I'd just remove this. My understanding
> on what I found on the net was that this would have the same effect as
> the Linux version so I considered it worth a try.

As discussed within the PR, https://wiki.freebsd.org/Networking still
references IP_SENDIF, so it seems to at least have existed some time
in the past.

Can anyone shed some more light on this part?

Best
Max
-- 
"I have to admit I've always suspected that MTBWTF would be a more useful
 metric of real-world performance."
 -- Valdis Kletnieks on NANOG



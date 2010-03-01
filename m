Date: Sun, 28 Feb 2010 21:52:32 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <54cde1cd4bdc1e82da3cb67831cc45c0@...1228...>
	<4B8A6E08.3090204@...1114...>
In-Reply-To: <4B8A6E08.3090204@...1114...> (from
	openvpn.list@...1114... on Sun Feb 28 07:22:16 2010)
Message-Id: <1267415552.30675.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN Pf plugin/small status patch
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
Cc: openvpn-devel@lists.sourceforge.net

On 02/28/2010 07:22:16 AM, David Sommerseth wrote:
> On 26/06/09 17:00, Arne Schwabe wrote:
> > Hi,
> >
> > I have written a simple plugin for packet filtering that looks up=20
> fw
> rules
> > in the order
> >
> > Commonname.pf
> > IP_Port.pf
> > IP.pf
> > default.pf
> >
> > If one of this files is found the file is used as PF configuration.
> Maybe
> > this plugin is useful for someone else.
>=20
> Hi!
>=20
> Thank you for your patches.  I've been looking at both patches, and I
> have some questions in regards to this plug-in.

I think that a vocabulary change could help avoid confusion, depending
on exactly what the proposed vocabulary is here.  "pf" is the offical
name for the OpenBSD packet filter.  IIRC it is also ported to FreeBSD
and perhaps elsewhere.  Using the name "pf" for this plugin could
be confusing.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein



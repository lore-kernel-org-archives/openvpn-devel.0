Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <20130108085201.GM22465@...1296...>
Date: Tue, 8 Jan 2013 07:41:59 -0600
Message-Id: <6726F5E5-673E-4B7F-87F8-70DB881FECB6@...1286...>
References: <00D1D856-A942-490E-957C-1BBD71ADE4B6@...1286...>
	<E1TsJSY-0007jC-0R@...1797...>
	<20130108085201.GM22465@...1296...>
Subject: Re: [Openvpn-devel] Correct Man Page: client-to-client
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

I'm certain this is the behavior for TAP, but I'll do some due-dilligence a=
nd generate a few different scenarios and verify.  It's entirely possible t=
his behavior is only present with the TAP adapter.  I'll post my findings l=
ater this week.
=20
-----
Eric F Crist



On Jan 8, 2013, at 02:52:01, Gert Doering <gert@...1296...> wrote:

> Hi,
>=20
> On Mon, Jan 07, 2013 at 09:38:02PM +0100, Davide Brini wrote:
>> The current documentation looks correct to me. When using client-to-clie=
nt,
>> traffic is not exposed on the tun interface; when not using
>> client-to-client, traffic shows up on the tun interface and can be
>> firewalled (eg with iptales).
>=20
> +1
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
> -------------------------------------------------------------------------=
-----
> Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
> and more. Get SQL Server skills now (including 2012) with LearnDevNow -
> 200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
> SALE $99.99 this month only - learn more at:
> http://p.sf.net/sfu/learnmore_122512_____________________________________=
__________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



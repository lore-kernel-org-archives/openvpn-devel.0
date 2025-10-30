MIME-Version: 1.0
References: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
 <28143412a9658f544a35b30e574cd3cfd98b08f7-EmailReplacePatchSet-HTML@...2715...>
 <CAKuzo_gpF7Tzx85O023M-sMqA7VJ0RZYvMnmEPDPccK3+gNfBQ@...278...>
 <aQOqhNumTK_4xu_9@...1296...>
In-Reply-To: <aQOqhNumTK_4xu_9@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 30 Oct 2025 23:16:03 +0200
Message-ID: <CAGyAFMVbQHx1RLVnPA8Tjdu5sLeYWnbwv-0Uos+aWA7=oi1Wvg@...278...>
Subject: Re: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv:
 validate openvpn-gui process path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

Indeed, this is to allow only programs under openvpn/bin talk to
interactive service.

Are there any valid use cases where any other processes are supposed
to talk to the service?

Note that this is not related to the original MSFT report - a
malicious process running as a pipe server received a connection from
openvpn-gui and impersonated as a user of openvpn-gui.

El jue, 30 oct 2025 a las 20:12, Gert Doering (<gert@...1296...>) escribi=
=C3=B3:
>
> Hi,
>
> On Thu, Oct 30, 2025 at 12:56:35PM -0400, Selva Nair wrote:
> > Do we really want to do this? I thought allowing any user process to use
> > the interactive service was deliberate: the only restriction being user
> > whitelisted as "OpenVPNAdministrators" or else we allow only a limited =
set
> > of config directives.
> >
> > Currently, starting openvpn.exe through the service using a script or a
> > custom application works. Without having to install it in the "OpenVPN/=
bin"
> > directory. Do we want to take away that functionality? The threat being
> > addressed here is unclear to me.
>
> I'm also sceptic on this.
>
> The report was, if I understand this correctly, about "non logged in
> users" to be able to access the pipe (by means of whatever means windows
> has for this).  "Only allow programs from openvpn\bin\ to access the
> pipe" fixes something else.
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doub=
ted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mist=
ress
>
> Gert Doering - Munich, Germany                             gert@...1296...



--=20
-Lev


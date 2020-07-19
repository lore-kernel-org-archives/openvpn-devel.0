MIME-Version: 1.0
References: <297271548.2761997.1595178366414.ref@...2084...>
 <297271548.2761997.1595178366414@...2084...>
In-Reply-To: <297271548.2761997.1595178366414@...2084...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 19 Jul 2020 13:23:49 -0400
Message-ID: <CAKuzo_h83g5HbWToLWoa5c9R-9i=hM6UefaLmKdAiW7z0feSFA@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Join PC with OpenVpn to Active
 Directory
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
To: Fermin Francisco <abcddo@...109...>
Cc: Openvpn Users List <openvpn-users@lists.sourceforge.net>, Openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

If your VPN establishes a route to the domain controller(s) and the
domain name resolves from the client, you can join the domain just as
you would do while directly connected to the LAN. For example, if the
domain name is example.local, "nslookup example.local" should return
the IP addresses of domain controllers, and those IPs should be
reachable from the client.

In the most common scenario where the domain controllers are on the
server-side LAN, this requires the VPN to set up a route to the
server-side LAN, and push a dns server that resolves the domain name.
Both of these are described in OpenVPN howto. See
https://community.openvpn.net/openvpn/wiki/HOWTO#Includingmultiplemachineso=
ntheserversidewhenusingaroutedVPNdevtun
and
https://community.openvpn.net/openvpn/wiki/HOWTO#PushingDHCPoptionstoclients


Selva

On Sun, Jul 19, 2020 at 1:07 PM Fermin Francisco via Openvpn-users
<openvpn-users@lists.sourceforge.net> wrote:
>
> Good afternoon!
>
> How Can I join a PC with openVPN to the Active Directory, does exists a m=
anual, Video, something like that??
>
>
>
> Jos=C3=A9 Ferm=C3=ADn Francisco Ferreras Registered User #579535 (LinuxCo=
unter.net)
>
>
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users


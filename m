MIME-Version: 1.0
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <046f2279-a275-aa18-40d9-9808512a6651@...2669...>
In-Reply-To: <046f2279-a275-aa18-40d9-9808512a6651@...2669...>
From: Tony He <huangya90@...277...>
Date: Tue, 29 Mar 2022 19:01:42 +0800
Message-ID: <CAAUX2SUFfkHAPaicEehzLvfNuXMHXfYhzV=CMk_v6oKcfJQRNA@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] can not delete tun interface
 automatically if option "user nobody" is used
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Timo Rothenpieler <timo@...2669...> =E4=BA=8E2022=E5=B9=B43=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=8C 18:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On 29.03.2022 12:21, Tony He wrote:
> > Hi,
> >
> > 1. Add option "user nobody" to test ovpn-dco.
> > 2. Start openvpn, below is the log. Then we will see tun0 is still
> > there after openvpn exit. We must use the command "ip link del tunX"
> > to delete. This is not friendly to end user.
>
> I think the dco only working if openvpn is running as root is a general
> issue right now.
Yes, I know that. Just in case user who is not openvpn expert  adds
this option by accident.
> Like, clients can't connect either, because it fails to communicate with
> the interface after dropping privileges.
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

Tony


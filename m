Message-ID: <547DDF5C.7010108@...1937...>
Date: Tue, 02 Dec 2014 18:48:44 +0300
From: Alexander Pyhalov <alp@...1937...>
MIME-Version: 1.0
References: <543B9FC6.3010800@...1937...>
In-Reply-To: <543B9FC6.3010800@...1937...>
Subject: Re: [Openvpn-devel] Default gateway can't be determined on
	illumos/solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 10/13/2014 13:47, Alexander Pyhalov wrote:
> Hello.
> In openvpn 2.3.4 on illumos/Solaris clients gateway for client can't be
> determined, because default stub is used instead of
> get_default_gateway() function. This means that the following push route
> option in server config is not working:
> push "route remote_host 255.255.255.255 net_gateway"
>
> OpenVPN  client says that it doesn't know net_gateway.
> The following patch mostly uses existing FreeBSD code to add
> get_default_gateway() implementation:
> https://github.com/pyhalov/oi-userland/blob/openvpn/components/openvpn/pa=
tches/get_default_gateway.patch
> .

Hello.
I've sent two patches (from apyhalov@...277... address) against 2.3 and=20
master branch), correcting  to the list, implementing=20
get_default_gateway() for Solaris / illumos platforms. Are there any=20
issues with them?
--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=9F=D1=8B=D1=85=
=D0=B0=D0=BB=D0=BE=D0=B2,
=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B8=D1=81=D1=82 =D0=BE=
=D1=82=D0=B4=D0=B5=D0=BB=D0=B0 =D1=82=D0=B5=D0=BB=D0=B5=D0=BA=D0=BE=D0=BC=
=D0=BC=D1=83=D0=BD=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D0=BE=D0=
=B9 =D0=B8=D0=BD=D1=84=D1=80=D0=B0=D1=81=D1=82=D1=80=D1=83=D0=BA=D1=82=D1=
=83=D1=80=D1=8B
=D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=BD=
=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D0=BE-=D0=BA=
=D0=BE=D0=BC=D0=BC=D1=83=D0=BD=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=
=BD=D0=BE=D0=B9 =D0=B8=D0=BD=D1=84=D1=80=D0=B0=D1=81=D1=82=D1=80=D1=83=D0=
=BA=D1=82=D1=83=D1=80=D1=8B =D0=AE=D0=A4=D0=A3


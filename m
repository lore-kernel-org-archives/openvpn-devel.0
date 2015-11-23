Date: Mon, 23 Nov 2015 21:05:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151123200530.GT24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
	<20151121200637.GD24952@...1296...>
	<CAN-X3HQ3jwUxchW=m-57TPBtfyv6E7bfY9fQJ3MH8godvf9nVQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCGU/3tJP9FZjbY4"
Content-Disposition: inline
In-Reply-To: <CAN-X3HQ3jwUxchW=m-57TPBtfyv6E7bfY9fQJ3MH8godvf9nVQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Pellegrin <chripell@...410...>
Cc: openvpn-devel@lists.sourceforge.net

--KCGU/3tJP9FZjbY4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 23, 2015 at 11:51:43AM +0000, Christian Pellegrin wrote:
> On Sat, Nov 21, 2015 at 8:06 PM, Gert Doering <gert@...1296...> wrote:
> >             if (sock->info.af =3D=3D AF_UNSPEC)
> > +               {
> >                    msg (M_WARN, "Could not determine IPv4/IPv6 protocol=
. Using %s",
> >                      addr_family_name(sock->info.lsa->bind_local->ai_fa=
mily));
> > +                  sock->info.af =3D sock->info.lsa->bind_local->ai_fam=
ily;
> > +               }
>=20
> Just tested, I ack it works perfectly. Thanks!

Thanks.  So I've committed the patch as appended (slightly different
format than the "usual" process as the original patch was no formal=20
commit yet, but message-id and ack etc. preserved)

gert
--KCGU/3tJP9FZjbY4--

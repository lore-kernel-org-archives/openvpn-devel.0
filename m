Date: Mon, 7 Sep 2020 17:11:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200907151139.GA75094@...1296...>
References: <20200907131734.31164-1-themiron@...2010...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ay//YxDA4vL4yocC"
Content-Disposition: inline
In-Reply-To: <20200907131734.31164-1-themiron@...2010...>
Subject: Re: [Openvpn-devel] [PATCH] Fix best gateway selection over netlink
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

--ay//YxDA4vL4yocC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 07, 2020 at 06:17:34PM +0500, Vladislav Grishenko wrote:
>      {
>          case AF_INET:
>              res.addr_size =3D sizeof(in_addr_t);
> -            req.n.nlmsg_flags |=3D NLM_F_DUMP;
> +            req.r.rtm_dst_len =3D 32;
>              break;

For the record, this actually doesn't work (long discussion on IRC),
so "NAK, followup patch coming".

Thanks for your work on this.

And perfectly on time to go into beta4 :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ay//YxDA4vL4yocC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfVk2qAAoJEB2Cnv7KVigSMDoMALVSReLXjocHS+yAwbR3MX6D
X7dotokaPuSGEMjlzP9rRC7sZWjK3qt6GwB8GOuRm/7WEPOjyaz4DptX8/FgnbTS
6t+QvC2aAkSTPc0xsQUfLeQFLXSxHvcKJx0gLMLdoiEwfyK3c1wPuLfIHxSktD5z
Vx0c90asHcigwh0BPTgSngFlLocs1uhEpxyTK/P2nT+/fCejo6tMmO4fzwvG4C6y
mzzbCJGy8aV2OeQzASsN5SAG6O4oY1PZBZXvvjIMTRUAiD9v6WHkWC2xHQmRNlCi
1XNNR/ZlVesi4IAr2SQaBRRbXDK5j4dHQuVledj89+RAesTMxRAThYpNMvwcgzTN
2p7+q4d2dRxY4EY2ctHTzW676M/G1/do/6RPnE9kdVMsGPcVo/rkpD0wWOieIpjt
hYOnqFp7G5w/ZzrgARD5nl6EBaL3nLGCIijNAD1nDT6zH2F6cgUMboit1FSWoaar
hfINm5hoxMtnEqBBdpuOfxc3cdrWLD2RS0tKIwV7jg==
=0H1X
-----END PGP SIGNATURE-----

--ay//YxDA4vL4yocC--


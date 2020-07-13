Date: Mon, 13 Jul 2020 17:40:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713154047.GF1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-13-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k8fM/ivQcxOOFHaz"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-13-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 13/14] client-connect: Implement
 deferred connect support for plugin API v2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--k8fM/ivQcxOOFHaz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:54AM +0200, Arne Schwabe wrote:
> The V2 API is simpler than the V1 API since there is no passing of
> data via files. This also means that with the current API the V2 API
> cannot support async notify via files. Adding a file just for async
> notify seems very hacky and when needed we should implement a better
> option when async is needed for the plugin V2 API.

I'm not sure I understand a word of this.

If we want async cc, we should do it in the V2 API - and since v2 plugin
async auth works just fine (with file), I wonder why it is hard for=20
async cc?  Because we cannot pass back the returned config data?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--k8fM/ivQcxOOFHaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDIB+AAoJEB2Cnv7KVigShzML/0PhB5GZQfwBOmzXdGJnZN+w
H3GQgQ8smtgP/LH6feGUp7bBfxpMAFwD8K9i20wdTdBe62ngagFhAYiTWFGz3Ajp
yJNIas+M1tfGh+0cCCeatPRuBJBphly9RP2kSoQOJzxKWAjsM0rcK/ZCePFbC211
D9PqFYBNo4fbcL1Hkm+kZ4E9MesW1Fa9mB1IXpb3sEiX8iAtP75t1lJ/TnP6QgQ5
Q0KpMsFPiQxkGXKo9VkXiYfPZevE4+A/M+WdcrqQT1utaG0tMGIpjmiUs1tbiEjs
UTqwMSVjnDu12evQFMo+1sOHGmQLh00cK5KBYeyXtYNs2THoOobsic2j/7+iH3Et
CPHwIIiew9q63nJov6olfHQRUxejaG+l3G290rWxiUC2eaLWjuIcDUcvOhhItef6
20PhDN5z9LC6sCmcoGzyX1s+DLWkbVM8R4nKMvLro9UOkqEgHrsOak7Qv6WrxQhK
WZUOyFbBQE4h4muV+lEx4p9Hd+UcBIk/TeJvFNllQw==
=fSwJ
-----END PGP SIGNATURE-----

--k8fM/ivQcxOOFHaz--


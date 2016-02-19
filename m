Date: Fri, 19 Feb 2016 12:37:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160219113726.GZ24952@...1296...>
References: <1455864663-19751-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1a65Nht3MERAq2eK"
Content-Disposition: inline
In-Reply-To: <1455864663-19751-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Restrict options/configs for startup
 through interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--1a65Nht3MERAq2eK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 19, 2016 at 01:51:02AM -0500, Selva Nair wrote:
> The pacth is in the next email.
>=20
> This is not yet tested extensively, but has passed some quick tests.
> A simple approach of parsing the options string is used instead of passin=
g structs:
> the latter will break the GUI everytime a new option is added to the whit=
e-list.
>=20
> Current white-list is just what the GUI needs, but its easy to extend.

Re-thinking the original argument, I agree that this is easier than
a fixed structure (if only because you'd need to ensure that GUI and
service are talking the same structure version...).

I like what your patch is doing - it's more than "just the whitelist"
but also the administrative restrictions ("if you are not administrator
or part of the OpenVPN Admin group, only configs from a well-known
directory, otherwise, do what you want").
--1a65Nht3MERAq2eK--

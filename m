Date: Mon, 12 Jun 2017 20:14:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170612181403.GK97029@...1296...>
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<1494008642-7239-2-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqiZnzhFL7JHQOqO"
Content-Disposition: inline
In-Reply-To: <1494008642-7239-2-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--NqiZnzhFL7JHQOqO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

wading through my heap of mails that did not get proper attention...

On Fri, May 05, 2017 at 02:24:02PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> If static challenge is in use, the password passed to the plugin by openv=
pn
> is of the form "SCRV1:base64-pass:base64-response". Parse this string to
> separate it into password and response and use them to respond to queries
> in the pam conversation function.
>=20
> On the plugin parameters line the substitution keyword for the static
> challenge response is "OTP". For example, for pam config named "test" that
> prompts for "user", "password" and "pin", use
>=20
> plugin openvpn-auth-pam.so "test user USERNAME password PASSWORD pin OTP"

What is the status of this one?  Does it need updating after 1/2 got
changed to v2 and v3 are these independent enough that 2/2 is standalone?
--NqiZnzhFL7JHQOqO--

References: <1476996158-5390-1-git-send-email-davids@...515...>
	<aa47d230-4e40-4ca3-9851-faf2470b7258@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9e45b369-8d4d-c29b-097e-17742c17840f@...2080...>
Date: Mon, 7 Nov 2016 21:52:20 +0100
MIME-Version: 1.0
In-Reply-To: <aa47d230-4e40-4ca3-9851-faf2470b7258@...277...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/11/16 16:07, debbie10t wrote:
>=20
> I would say that these .service files are likely to temporarily
> break (m)any existing systemd usage until admins change their
> configs. Especially use of --cd
>=20

I forgot to comment this one.

No existing installations should break by installing these unit files.
 To my knowledge all distros use variants of either openvpn.service or
openvpn@...1685... unit files.  So users can migrate from the old layout
to our new ones gradually.

This is also one of the reasons I've not chosen to re-user the
openvpn@...1685... scope and have a unified unit file for both server
and client mode.  (Another reason is that they do not require the same
set of arguments and privileges/capabilities - but this is a different
discussion).

And if an OpenVPN configuration file contains --cd, that doesn't mean
it will break either.  It *might* break if a config contains '--cd
$RELATIVE_PATH', as the starting point will be different.  This
basically is the same situation for all options having a file argument
(script hooks, cert/key files, plugin, etc).  So the risk is most
likely somewhat higher for those options than --cd.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIOmEAAoJEIbPlEyWcf3yPjQP/0UuB2YPtShyVIUSfPHmbvyC
b9mtXbvTOHMhHY8wV9xrZFH89+G69+jOvVfuZGfHdRssJdxnbRmF0C2TZbIzcTs/
gFL6Z90PxILXAm4b7202RaYax0pFI6iGKoTlEQ7XSpvNURHMVMfikJxY6v0faHf+
cR2eUOD3A+6Zz1Q+zszGUsWPPTdSeS87KiK4y71Bdvh4dZEGxtgIGiTGcF46PftZ
IhfTYn8vVYF+78raacBL3QuO4hKjc5wVSFD8txNDWR6qzQf50glW1f5oPh2p7EgK
lQvzssJRZyxJv/N6TxA5JgDyLAOndRhEF41KB1JoBcsVhMGqnpE8tEynyARc9rct
u9mUI73Zf+4V8NvzpE4Zp7A9DyIIfFFUE2Ys4WStjrZT+2vbWjS+6gtO2qop4azw
NLAUTwVjeAV2z3zLBmc9KgQ/m1uwNQQFV4+bWKIBjUMsezt2bV/QlhpFPX8CeZBF
njktyKsHg1ps3+O6zqh18QIZHaVz5MyItfG3F7Ai0wSQeklAvOr7M82jxkVM6gv+
17SvsH/xIlh37S8Nt/fI9hD3lyioyQzy3wVEznjNWalQZVbLCZw/xJWg1h76N+QP
FFM4t9xwoG6VHWH3ZfqqrGimEo11lBU/pzcjhQPWhgNBMJlnaUJnY0DRIgG3yDFH
WX6HrrCe5BkXRwKBlr04
=3DD5ju
-----END PGP SIGNATURE-----


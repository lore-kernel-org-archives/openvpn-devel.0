Date: Sun, 28 Mar 2021 17:57:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210328155748.GF976@...1296...>
References: <CAALvpZQ-5bSb0h7N+Jdxni+Ss_LRLo6KwAzL3XP6XTj4ijYzkA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yriehv0T8/Qrjrwv"
Content-Disposition: inline
In-Reply-To: <CAALvpZQ-5bSb0h7N+Jdxni+Ss_LRLo6KwAzL3XP6XTj4ijYzkA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?T=F5ivo_Leedj=E4rv?= <toivol@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--yriehv0T8/Qrjrwv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 28, 2021 at 03:51:39PM +0200, T=F5ivo Leedj=E4rv wrote:
> The getpass() function is present in SUSv2, but marked LEGACY. It is
> removed in POSIX.1-2001. Additionally, on Solaris getpass() returns
> maximum 9 bytes. This will make longer passwords fail with no
> possibility for user to know what is happening.

Thanks.  Unfortunately, your MTA mangled this in horrible ways (long
lines have been wrapped, and the tabs in the configure.ac lines replaced
with blanks) - so git refuses to apply unless I mangle it manually.

Can you re-send with "git send-email"?  This is usually very good in
not getting its patches mangled.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yriehv0T8/Qrjrwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgYKd7AAoJEB2Cnv7KVigSQdQL/3x2Gyq8n7WsUCIUMmPzDHUy
xaVHws79XQAJ1NSawLkk7EWLELOtduOWPbixtcfLBkFcPdnFGtFL5cj3+zJ/GV4y
X4uOArQ873V5FDbzHiZtntunrOQP9KS5h15YQXlFjb8rcrxOqovPTu8RfejFt/IE
3y4q6AazWo59xLhuDFFo6WMorckUEc0l32BoqzXD67oi2tQibqY1pSQUeASl8XJ0
bbQgOtx0fxuAMtxwRRLhj2HsN+Y3+t6/ZDuTt/c9sPPYXsKHK0M1/9h3bALrNHkP
27MPkHGGsZ4rfBnmxg8GuNHmx3fkqSbcVMMApP2pZaCbI8FuKpAtexLU5eYLiBOW
qPxm2/j8525oK6mzS7AGbJGPNBD2kRLzmf1eNOo/NC2o15mJqBNuoFjTdKrvsA7X
r7bYhXw5U8YRN5CzeYA723PPrXyEWIDaC9fk+45wI82TRLn5vPnIalAk1UqhqatZ
nalfNhpiiD7ny/ErZSFxyHpwGgYZwLAVwSZ0bouhgA==
=fT65
-----END PGP SIGNATURE-----

--yriehv0T8/Qrjrwv--


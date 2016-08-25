From: David Sommerseth <openvpn@...2080...>
Message-ID: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
Date: Thu, 25 Aug 2016 15:45:24 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC] - Enable 2FA to be used with renegotiations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

I've been working a bit on a new patch-set which enables third-party
user/password authentication mechanisms using two factor
authentications [2FA] (such as OTP) and not needing to disable the
renegotiation features of OpenVPN.

Currently, if a server is configured with 2FA using for example
HOTP/TOTP tokens, each renegotiation of the tunnel would require the
user to provide a new OTP code.  The current workaround have been to
disable the renegotiation (which by default happens once per hour).
It is also not considered ideal to disable the renegotiation.

The patch-set I have worked on fixes this by adding a new server side
option, --auth-gen-token.  This makes use of a feature already found
in OpenVPN clients.  If a server pushes 'auth-token $TOKENVALUE' to a
client, it will replace the currently locally stored password with
$TOKENVALUE.  Next time the OpenVPN tunnel is rengotiated, the
$TOKENVALUE will now be passed instead to the server along with the
username.

What the patch-set does is:

- - Add --auth-gen-token, and when used the following steps happens

- - After a successful normal user/password authentication, it will
  generate a random token for this tunnel and keep a local copy of it.
  This token is currently set to 256 bits (32 bytes).

- - It will push 'auth-token $RANDOM_TOKEN_VALUE'.  The
  $RANDOM_TOKEN_VALUE sent to the client is BASE64 encoded.

- - When a re-authentication happens, and the server sees it have
  a token and the token have been sent to the client, it does an
  authentication of the token alone.  Any --auth-user-pass-verify or
  --plugins enabling OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY will not
  be called at this point.  On successful token authentication,
  everything continues as before.  On failure the session is considered
  un-authenticated and a complete new authentication round is required.

If --auth-gen-token is NOT used, OpenVPN will behave as before.

The patch-set can be found here:
<https://gitlab.com/dazo/openvpn/compare/master...dev%2Fauth-gen-token>

And the git tree can be found here:
<https://gitlab.com/dazo/openvpn.git>
(Check out the dev/auth-gen-token branch)

I do not yet consider this patch-set ready for inclusion yet, it needs
a lot of testing and reviewing .  But it should work.  The patch-set
is broken into smaller pieces to try to make the overall
implementation more transparent, easy to review and easier to git
bisect when needing to debug.  Each commit level should compile
cleanly.   Please feel free to comment inline.


- --=20
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXvvZzAAoJEIbPlEyWcf3yLmEQAIDMdZBeiz5lXtRENXGm/fW6
ZUKIYSlw0TITQgeGWc6hFcAXCWLVtj4SiLLmtcZ25UrbXc+do2c8IFuHkoDIVrif
mEL8mw/+Cgy6ch2DZrT779KneeuArRsimPyquVq8NLZ3UGIqcwWYpeI9GES51SAe
dQVwOmpojStOFLmmxoEC0i4oSpjtm0L2U6o6ytl+140yMVj92ADmH9Vow4G1velF
7lAkfJxabUn6sch/Y87Ny4SG5u0jkgzerikOGSuGAafnWQKejKbdADnxuMhx/3Qb
gnDHyrfUeiwgIOtYZ2pNflG8FT4AdJDuXYTcjJQu+yS0N0cXT0w0sBYahQrXcPjY
N2Lumk6qq39N+INnS8x310CfUBQ1rO4fxZX8kZEwIZzXPu3VDCSWcqwAcIIWylQZ
gx481kO8O04cFyJdlkgr1vb+fgIM2PlXIn/hnxpfjSuJPf+1MHPee0NVS4dcYWPg
oMoo7bVOv+UVV85qy3I3TPCt+7fGF3dG+JQEEW/xOT90G+z+o2u4ZuS2uxL9n5fJ
0H0mHd6LkHR3vlxbtJjDOkqOZIdhNwFamkVK3jj5IF7C+v1WaMlK2Vy4ifiCz8p5
C+bHYo9zjA8+Tv3PRNRwpPbVLyFFhV0poe/hFC2ch3/Zq8X/ZHGZNWoXgnNAx7kh
ByHclsBZa5kbGqEy2zVr
=3DYnjq
-----END PGP SIGNATURE-----


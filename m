Message-ID: <4FA23523.2030706@...1114...>
Date: Thu, 03 May 2012 09:34:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
	<20120323141815.GC1359@...1296...>
	<CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
	<4F73545A.8020303@...1114...>
	<CAEsd45RkyJw6yUk1Jwkip70HkCjKYoU+V=do3N7SH7JOaHBZdw@...278...>
In-Reply-To: <CAEsd45RkyJw6yUk1Jwkip70HkCjKYoU+V=do3N7SH7JOaHBZdw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB60DD3414A286A7AD2324635"
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
 contains more than an execution path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB60DD3414A286A7AD2324635
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 31/03/12 13:47, Jonathan K. Bullard wrote:
> On Wed, Mar 28, 2012 at 2:11 PM, David Sommerseth
> <openvpn.list@...1114... <mailto:openvpn.list@...1114...>>
> wrote:
> <snip>
>=20
>     > Attached is a heavily revised version of my original patch. It uses
>     > argv_printf() to __check__ an option's commands, so it accepts exac=
tly
>     > the same input as the parts of OpenVPN that __use__ the options'
>     > commands. It also makes all the relevant changes suggested by Gert
>     > except having the argument following --iproute checked. The --iprou=
te
>     > code is handled differently than the other options, and I think it =
is
>     > OK that we don't do checking in 2.3 on something that wasn't checked
>     > in 2.2 and (apparently) might go away sometime soon.
>=20
>     Thanks a lot!  I have one more comment to what Gert and Fabian has
>     already covered.
>     Instead of adding  wrapper function, check_cmd_access(), would it be
>     possible to
>     integrate this with check_file_access() and add another type flag, f.=
ex:
>=20
>     #define CHKACC_EXEC (1<<5)  /** Filename is an executable, ignore exec
>     args */
>=20
>     Then you can just flip the type flag from CHKACC_FILE to
>     CHKACC_EXEC.  If
>     this
>     type is checked for, enforcing an X_OK mode check in addition is
>     probably
>     reasonable
>     too.
>=20
>=20
> Thanks for this suggestion, David, but I believe it is better to create
> a separate routine for this:
>=20
>  1. The input is not a path, but a "command". A "command" is processed
>     (single- and double-quote and backslashes are processed and leading
>     spaces are removed), and it consists not only of a path, but may
>     include arguments.
>  2. Having two separate functions makes two cleaner and more readable
>     (to me) functions, instead of a single function that accepts strings
>     with two different formats and is more complicated.
>=20
> The first attached patch incorporates Fabian's comments. But if the
> consensus is that I should incorporate David's suggestion, I will do that.
>=20
> The first patch also updates the usage message to clarify what a "cmd"
> is. (That is, it is /not/ a shell script or path.)
>=20
> The second patch updates the man page to:
>=20
>   * Clarify what a "cmd" is;
>   * Change the descriptions of several options to note that they accept
>     a "command";
>   * Change the description of --client-connect and --client-disconnect
>     indicate that the temporary file's path is passed as the /last/
>     argument to the command, not the /first/ argument; and
>   * Adds a description of --route-pre-down to the descriptions of the
>     other --route options.
>=20
> Thanks again to Fabian, Gert, and David for their help.

Sorry for the late response, but this got applied yesterday to the master b=
ranches on -stable and -testing trees.

I took the freedom to re-arrange your patches and make the commits more rel=
ated to each other and to quickly create a couple of commit messages.

commit d62859980c30362b36b7338fc99fe76e4ecb2cbd
Author: Jonathan K. Bullard <jkbullard@...277...>
Date:   Sat Mar 31 07:47:34 2012 -0400

    Clarified the docs and help screen about what a 'cmd' is
=20=20=20=20
    This also changes the descriptions of several options to note that they=
 accept
    a "command"; change the description of --client-connect and --client-di=
sconnect
    indicate that the temporary file's path is passed as the last argument =
to the
    command, not the first argument; and Adds a description of --route-pre-=
down to
    the descriptions of the other --route options.
=20=20=20=20
    [DS: This patch is based on parts of the options.c.diff and the complete
         openvpn.8.diff patch sent to the mailing list - where these docs c=
hanges
         are merged together into this patch]
=20=20=20=20
    Signed-off-by: Jonathan K. Bullard <jkbullard@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: CAEsd45RkyJw6yUk1Jwkip70HkCjKYoU+V=3Ddo3N7SH7JOaHBZdw@...1664...=
8...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6194
    Signed-off-by: David Sommerseth <davids@...1347...>

commit a050bcef9cf71e7479551677b116879e6c563bd5
Author: Jonathan K. Bullard <jkbullard@...277...>
Date:   Sat Mar 31 07:47:34 2012 -0400

    Fix file access checks on commands
=20=20=20=20
    The current implementation of check_file_access() does not consider that
    some options take scripts and executables as input.  When some of these
    commands are given arguments in the OpenVPN configuration,
    check_file_access() would take those arguments as a part of the file na=
me
    to the command.  Thus the file check would fail.
=20=20=20=20
    This patch improves that by introducing a check_cmd_access() function w=
hich
    first splits out the arguments to the command before checking if the fi=
le
    with the command is available.
=20=20=20=20
    [DS: This patch is splitted out from the options.c.diff patch sent to t=
he
         mailing list - where only the function changes is included here]
=20=20=20=20
    Signed-off-by: Jonathan K. Bullard <jkbullard@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: CAEsd45RkyJw6yUk1Jwkip70HkCjKYoU+V=3Ddo3N7SH7JOaHBZdw@...1664...=
8...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6194
    Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth




--------------enigB60DD3414A286A7AD2324635
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+iNSMACgkQDC186MBRfrpMxACgrR/0Sx+0FTNxTbdVjNJHF1sK
T6EAn04AgEEjy1QGGIWPWcUAmJXjxKbv
=ctBI
-----END PGP SIGNATURE-----

--------------enigB60DD3414A286A7AD2324635--


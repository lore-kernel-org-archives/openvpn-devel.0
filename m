Message-ID: <4F73545A.8020303@...1114...>
Date: Wed, 28 Mar 2012 20:11:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
	<20120323141815.GC1359@...1296...>
	<CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
In-Reply-To: <CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/03/12 15:03, Jonathan K. Bullard wrote:
> On Fri, Mar 23, 2012 at 10:18 AM, Gert Doering <gert@...1296... 
> <mailto:gert@...1296...>> wrote:
> 
> Hi,
> 
> <snip>
> 
> Thank you, Gert, for your detailed comments on my first attempt at
> this patch.
> 
> The patch is meant to fix problems in the new-in-2.3 checking of
> options before trying to create the connection. Options that accept a
> command parameter instead of a path parameter fail if the command
> parameter includes spaces or more than just a command path. The
> following options are affected: --tls-verify, --up, --down,
> --ipchange, --route-up, --route-pre-down, and --learn-address.
> 
> I've looked into this a bit more, and have found that where the
> options are actually used, argv_printf() is called to parse the
> command line into an argv structure. argv_printf uses parse_line() to
> do the actual parsing, and parse_line() processes single- and
> double-quotes and backslashes. I think that when options.c __checks__
> an options command arguments, it should accept exactly the same input
> as the part of OpenVPN that __uses__ the option's commands.
> 
> Attached is a heavily revised version of my original patch. It uses 
> argv_printf() to __check__ an option's commands, so it accepts exactly
> the same input as the parts of OpenVPN that __use__ the options'
> commands. It also makes all the relevant changes suggested by Gert
> except having the argument following --iproute checked. The --iproute
> code is handled differently than the other options, and I think it is
> OK that we don't do checking in 2.3 on something that wasn't checked
> in 2.2 and (apparently) might go away sometime soon.

Thanks a lot!  I have one more comment to what Gert and Fabian has
already covered.
Instead of adding  wrapper function, check_cmd_access(), would it be
possible to
integrate this with check_file_access() and add another type flag, f.ex:

#define CHKACC_EXEC (1<<5)  /** Filename is an executable, ignore exec
args */

Then you can just flip the type flag from CHKACC_FILE to CHKACC_EXEC.  If
this
type is checked for, enforcing an X_OK mode check in addition is probably
reasonable
too.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9zVFcACgkQDC186MBRfrpH4ACfQ/9ySeXkOnuxI/jaEpgKmpXG
c6kAnRVnqYIvQ6dH1rfXjyj5IUpBMh6+
=bTBw
-----END PGP SIGNATURE-----


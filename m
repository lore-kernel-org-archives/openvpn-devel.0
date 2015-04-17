MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 17 Apr 2015 05:28:45 -0400
Message-ID: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
Subject: [Openvpn-devel] OpenVPN argument parsing of most options ignores
	"extra" parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I would like to propose a patch which complains if OpenVPN options
include parameters that are not expected.

If possible, I would like to get a "feature ACK" consensus before I
create the patch. (If I get a "feature NAK" then I won't create the
patch.)

The patch would be to reject options that are followed by extra parameters.

The error message would change from
     Options error: Unrecognized option or missing parameter(s)
to
     Options error: Unrecognized option or missing or unexpected parameter(s)

Perhaps the current behavior of ignoring "extra" parameters is
purposeful, to allow options to have parameters that are ignored by
"old" versions of OpenVPN but accepted and acted on by "new" versions
of OpenVPN. (I think doing that is not a good idea, but maybe that's
the way the community wants it.)

The patch would break any configurations that have such "extra"
parameters. I think that's good, because the configurations are, well,
wrong. But there could be a lot of such configurations being used with
current versions of OpenVPN -- who knows?


**EXAMPLE**

Here is the code in the add_option routine in src/openvpn/options.c
that processes "--mtu-test", which has no parameters:

  else if (streq (p[0], "mtu-test"))
    {
      VERIFY_PERMISSION (OPT_P_GENERAL);
      options->mtu_test = true;
    }

If there is an argument at p[1], this argument will be ignored.

I tested this by adding a line
     mtu-test FOO
to a configuration file. When I try to connect, OpenVPN connects
normally without indicating anything is wrong.

Similarly,
     mtu-test verb 9
works without a problem. (And ignores the "verb 9", of course.)

My proposed patch would change the above code for mtu-test to:

  else if (streq (p[0], "mtu-test") && !p[1])
    {
      VERIFY_PERMISSION (OPT_P_GENERAL);
      options->mtu_test = true;
    }

and would include similar changes for most other options. Options that
take an arbitrary number of parameters or accept the rest of the line
as a parameter would not be modified, of course.

(In patch format, it would be:
-  else if (streq (p[0], "mtu-test"))
+  else if (streq (p[0], "mtu-test") && !p[1])
)

It don't think it is necessary to include "&& !p[2] && !p[3]...",
although it might be possible to end up with a p[ ] array with
"skipped" parameters by using a command line like:
     openvpn --mtu-test "" FOO
(I don't know if this would work; I haven't examined the code for this
or tested it.)

Thoughts?


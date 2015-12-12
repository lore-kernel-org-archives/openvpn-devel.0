MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 12 Dec 2015 16:47:48 -0500
Message-ID: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
Subject: [Openvpn-devel] Options that are "safe" for users to modify?
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

Inspired by Gert, I am considering adding a new feature to Tunnelblick
(FOSS GUI for OpenVPN on OS X) and would like your reactions. In an
earlier thread on openvpn-users, my original more grandiose idea was
(with good reason) NAKed. It was also suggested that openvpn-devel was
a better place for the discussion.

The goal is to allow a non-admin to update keys and certificates
without needing the admin authorization that is currently required by
Tunnelblick. Changing Tunnelblick so that it runs OpenVPN as the user
is one way of doing that, but is much more work and has broader
consequences than what I am proposing and I'd like to avoid discussion
of that in this thread if possible.

Tunnelblick currently "secures" OpenVPN configuration files and the
files they reference (e.g., "targets" of --ca, --key, etc.) by making
them writable only by root. A user can change a configuration only by
getting admin authorization. (Some files may be readable only by root,
too, but that's not relevant here.)

What I am proposing is for Tunnelblick to allow the user to replace
certain files referred to in a configuration without admin
authorization. This would be done by allowing changes to files
referenced by options that are on a whitelist. So what options should
go on that whitelist?

My tentative plan is to allow users to update without authorization
any files that are the "targets" of the following options:

--askpass
--auth-user-pass
--ca
--cert
--dh
--extra-certs
--key
--pkcs1
--static
--ta
--tls-auth

I'm not proposing to let the user modify the files directly -- they
would continue to be writable only by root. The files would be
modified by the same privileged Tunnelblick daemon that starts OpenVPN
as root ( and which will enforce the restrictions).

The original implementation would only replace files but it could be
extended to replace inline options in the configuration file itself,
too.

My hope is that it would be "safe" to allow this, in the sense that
the user couldn't get themselves into much trouble: no escalation of
privileges, no messing up routing tables, etc. I think the worst that
could happen is that a configuration would stop working. (But I'd like
some reassurance that that is true, which is why I'm asking for your
advice.)

For anyone interested, it would work like this: the simplest
Tunnelblick configuration is a folder with an extension of ".tblk"
that contain one .ovpn file and all the files referred to in that
file. A Tunnelblick configuration is installed or replaced by
double-clicking it, which invokes Tunnelblick to do the
installation/replacement. Currently, installing or replacing (or
deleting) a Tunnelblick configuration requires getting authorization
from an admin; the plan is to skip the authorization if replacing and
the only changes are to files as described above. So double-clicking a
.tblk for the original installation would need admin authorization,
but double-clicking it to replace a configuration would not, as long
as the only changes were to the files described above. Double-clicking
a replacement .tblk that includes a modified OpenVPN configuration
file itself (or script files, etc.) would continue to require admin
authorization. System admins would distribute a single .tblk that
could be used to do either an original install or a replacement;
Tunnelblick would figure out which it was and get authorization or
not. The ability to do these non-admin-authorized replacements would
be disabled by default and would need to be authorized by an admin, so
it would only work for users if the admin wants it to.

Reactions? Thanks in advance. (Oh, and please don't blame Gert for any
of this; any good ideas are his but I'm to blame for any bad ones : )


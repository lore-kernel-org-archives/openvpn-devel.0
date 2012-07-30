Message-ID: <5016BEFA.8030901@...1114...>
Date: Mon, 30 Jul 2012 19:06:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1343666121-19765-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343666121-19765-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [RFC] give plugins a method to pass log lines
 to openvpn
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/07/12 18:35, Heiko Hund wrote:
> Some plugins want to add messages to the openvpn log file.
> 
> V3 plugins can indirectly write to the log by specifying one or 
> more openvpn_plugin_log_list structs and returning them in the 
> provided openvpn_plugin_args_{open,func}_return struct.
> 
> The openvpn plugin backend will log the provided information upon
> reception.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- 
> include/openvpn-plugin.h |   39
> ++++++++++++++++++++++++++++++++++++++- src/openvpn/plugin.c     |
> 37 +++++++++++++++++++++++++++++++++++++ 2 files changed, 75
> insertions(+), 1 deletion(-)

Just a few quick thoughts.  As the implementer of the v3 API, I'm
happy to see such attempts.  And as the developer of eurephia (which
is an authentication plug-in for OpenVPN), I see the need for such a
feature.

But I'm not fully convinced yet this is the proper way.  In many ways,
it is elegant, but in some parts I feel it falls short too.  But it is
a good starting point for a discussion.

The advantage of the log struct is that the plug-in can have far
better control on how to format the log data.  But it raises the
complexity as each plug-in with this proposal needs to write their own
logging mechanism which does the pointer-chain stuff.  And adding new
structs have the pitfall that it's easy to not be ABI (not API)
compliant across versions, something the v3 plug-in API strives for.
I would expect the vast majority of all plug-ins don't require this
kind of flexibility.

My immediate thought/question is: Why can we not export msg() to
plug-ins?  Or at least provide something more like a functional
oriented API to work with?

What if we extend the openvpn_plugin_args_open_in struct to include a
function pointer to a log function?  This log function can provide
somewhat the same feature set as msg().  But it should also prefix
these log lines as coming from a plug-in (preferably with the plug-in
name included)... plug-ins wanting to log, can then save that function
pointer and call this directly.

It's not so flexible as this current proposal can be, but it should be
easier to provide a more predictable ABI for the future,  And it would
cover the use case for most of the plug-ins.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAWvvcACgkQDC186MBRfrpQ2ACeMoAv/ugw+V0SMvxUSLm8iXw/
AWoAnj8O8c9OV0BmpC37MpFuSr0qGsgh
=2RqT
-----END PGP SIGNATURE-----


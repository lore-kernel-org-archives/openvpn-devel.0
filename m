Date: Thu, 14 Aug 2008 14:34:12 -0400
From: Mike Kasick <mkasick-od@...1121...>
Message-ID: <20080814183412.GA22499@...1121...>
MIME-Version: 1.0
Subject: [Openvpn-devel] 2.1_rc9/r3122 breaks verify-cn script and
	tls-verify multiple argument behavior
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

The change from using system() to execve() introduced as part of the
defensive programming changes in r3122 breaks the supplied verify-cn script
and recommended usage of multiple arguments with the --tls-verify option.

From openvpn(8):

"Note that cmd can be a shell command with multiple arguments, in which
case all OpenVPN-generated arguments will be appended to cmd to build a
command line which will be passed to the script."

Of course, by using execve() instead of system() this is no longer true.
Multiple arguments are interpreted as part of the script file name itself.

I use a script with tls-verify that's similar to the supplied verify-cn, in
that it checks the Organizational Unit of the certificate against the one
supplied via command line (and thus, specified in the config file).  I'd
rather not hardcode the comparison name, and it would be my preference not
to pass it as an environment variable either.

Is there another workaround that would let me specify aditional parameters
to the tls-verify script from the config file?

At the very least, the man page and the header of the verify-cn script
should be updated to reflect that this behavior is no longer supported.

Thanks!


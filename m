From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] beta-18 crash
In-Reply-To: <02b601c4d6e9$fb21b1f0$0600000a@...139...>
Message-ID: <Pine.LNX.4.58.0411301625200.3572@...41...>
References: <02b601c4d6e9$fb21b1f0$0600000a@...139...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov 30 15:39:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Gisle Vanem <giva@...258...>
Cc: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

On Tue, 30 Nov 2004, Gisle Vanem wrote:

> Simply running "openvpn -h" causes a SIGSEGV. I was hoping '-h' would 
> print the help, but obviously not. Happens with '-v' too.

Interesting bug.

Basically "openvpn -h" is incorrect usage and should produce a basic
options parsing error message, and in fact it does this on *nix, but
crashes as you noted on Windows (openvpn --help will print the help).

The crash traces back to a simple incompatibility between win
and *nix.  On Windows, socket descriptors are unsigned, on *nix they are 
signed.  Commonly, -1 is used to denote an unopened file descriptor, but 
OpenVPN made the mistake of assuming that (fd >= 0) is sufficient to test 
for a valid fd.  If fd == -1, then (fd >= 0) is only true if fd is a 
signed type (yeah C is crazy, if you say "unsigned int fd = -1;" then test
for fd > 0, the test will be true).

Because of the way the new management interface works on beta18, any early 
fatal error messages (such as due to command line option errors) will 
trigger this bug.

I will fix for beta19.

James


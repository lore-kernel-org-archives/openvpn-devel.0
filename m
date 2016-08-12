References: <1470943420-15103-1-git-send-email-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4f37aef4-3e89-ccbd-4245-b033892cf1c2@...2080...>
Date: Fri, 12 Aug 2016 12:03:33 +0200
MIME-Version: 1.0
In-Reply-To: <1470943420-15103-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Change timestamps to POSIX format.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/08/16 21:23, Gert Doering wrote:
> All our timestams used to be "what ctime()" produces, which is
> 
> "Thu Aug 11 21:15:27 2016"
> 
> Changed to use POSIX standard format, which is
> 
> "2016-08-11 21:15:27"
> 
> this applies to logging (except to syslog or if
> --machine-readable-ouput is used) and to various other places where
> informational timestamps are produced.  Among these are the status
> files / status to management interface, so applications parsing
> these time stamp need to be adjusted.
> 
> trac#719
> 
> Signed-off-by: Gert Doering <gert@...1296...> --- 
> src/openvpn/otime.c | 7 +++++-- 1 file changed, 5 insertions(+), 2
> deletions(-)
> 

I generally think this is a very good idea.  But I fear what we break
along the way.

It would be great if as many as possible could put this into somewhat
limited production environment for testing if this breaks any thing
*and* report back after a while; even if no issues where detected.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAletnvUACgkQDC186MBRfrqAhQCgm79bWoRc0Rx8yfDPfkghhaxC
ppUAoKsW896yhktq76znVoPagDWvlo7n
=IR81
-----END PGP SIGNATURE-----


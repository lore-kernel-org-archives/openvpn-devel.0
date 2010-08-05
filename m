Message-ID: <4C5B0D23.5000401@...1114...>
Date: Thu, 05 Aug 2010 21:12:35 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <201005011842.30097.dave_br@...1278...>
	<1272798458-1175-1-git-send-email-dave_br@...1278...>
In-Reply-To: <1272798458-1175-1-git-send-email-dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Exclude ping and control packets from
 activity
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/05/10 13:07, Davide Brini wrote:
> Problem: using --ping and --inactive together partially defeats the
> point of using --inactive as periodic ping packets are counted as
> activity. Here is the original discussion:
> 
> http://article.gmane.org/gmane.network.openvpn.devel/3676
> 
> It turns out that "activity" is detected and recorded in two places
> in the code, both in forward.c: in process_outgoing_tun() for received
> packets, after they've been decrypted and sent to the TUN device; and
> in process_outgoing_link(), after they've been encrypted and written
> to the network socket.
> 
> In the first case we can be sure that packets that get so far are
> really due to user activity, whereas in the second case there can be
> non-user packets (like OpenVPN's internal ping packets, and TLS control
> packets), and those should not be counted as activity as they are not
> coming from the user.
> 
> So a need arises to detect those control packets and not count them as
> activity for the purposes of --inactive. Unfortunately, at that stage
> packets are already compressed and encrypted, so it's not possible to
> look into them to see what they are. However, there seems to be a
> convention in the code that packets whose buffer length in the context_2
> structure is 0 should be ignored for certain purposes. TLS control
> packets follow that convention already, so this patch makes a small
> change in the code that generates the ping packets to set their buffer
> length to 0 as well.
> Finally, the call to register_activity() in process_outgoing_link() is
> made conditional to the buffer length being > 0.
> 
> According to my tests, now --inactive behaves correctly according to
> the configured parameters (time or time+bytes) even when --ping is
> being used.
> 
> forward.c:
>     Call register_activity() in process_outgoing_link() only if the
>     packet is not a ping or TLS control packet.
> 
> openvpn.8:
>     Updated the description of --inactive to describe the new semantics.
> 
> ping.c:
>     Set c->c2.buf.len = 0 after the ping packet has been generated and
>     encrypted.
> 
> Signed-off-by: Davide Brini <dave_br@...1278...>
> ---
>  forward.c |    5 +++--
>  openvpn.8 |   20 +++++++++++++++-----
>  ping.c    |    2 ++
>  3 files changed, 20 insertions(+), 7 deletions(-)


Applied to bugfix2.1 and merged into allmerged.

commit 2cde039a0add05f071f0f5bc9beee826d8cb8dd8
Author: Davide Brini <dave_br@...1278...>
Date:   Sun May 2 11:07:38 2010 +0200

    [...snip...]

    Test routine is described here:
    <https://community.openvpn.net/openvpn/wiki/PingInactivePatch?version=6>

    Signed-off-by: Davide Brini <dave_br@...1278...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxbDSMACgkQDC186MBRfro1EACfRBzynh1DKH3bE8PMbdeGfK1W
8usAoJ/VTW+CUofc6q+Jr0uUO4xKnHb6
=Ay/s
-----END PGP SIGNATURE-----


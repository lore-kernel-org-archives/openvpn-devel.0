Date: Thu, 4 Jan 2024 16:44:59 +0100 (CET)
Message-Id: <202401041544.404FixKl091648@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240104140214.32196-1-gert@...1296...>
References: <20240104140214.32196-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check PRF availability on
 initialisation and add --force-tls-key-material-export
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Previous versions of the patch had issues with string concatenation
(missing whitespace) - all fixed.  Also, the manpage would claim
auto-activation of the feature, which it didn't -> fixed as well :-)

Testing with manual activation of --force-tls-key-material-export led
to the expected result - 2.6 clients could connect fine, 2.5 and earlier
were refused with a clear message:

  2024-01-03 18:35:45 AUTH: Received control message: AUTH_FAILED,Client incompatible with this server. Keying Material Exporters (RFC 5705) support missing. Upgrade to a client that supports this feature (OpenVPN 2.6.0+).

and on the server

  2024-01-03 18:37:52 us=455522 cron2-freebsd-tc-amd64-25/2001:608:0:814::f000:21 peer-id=0 PUSH: client does not support TLS key material exportbut --force-tls-key-material-export is enabled.

so, this should help people hitting such a scenario to much better understand
what is happening, and what they can do about it.


For completeness I've tried to test this on a FreeBSD 14 system with
"--providers fips", but failed to set up OpenSSL/FIPS in a way that
actually did anything useful...  so I broke check_tls_prf_working()
manually, and the expected "auto-enable option" part works too (in v9).

Your patch has been applied to the master and release/2.6 branch (long-
term compat and better diagnostics).

commit fa7960961415fa4f368e9bbb39dc4047680ff30c (master)
commit b29ada314cc79497a1e50e29b4b72dede2955b3d (release/2.6)
Author: Arne Schwabe
Date:   Thu Jan 4 15:02:14 2024 +0100

     Check PRF availability on initialisation and add --force-tls-key-material-export

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240104140214.32196-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27924.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering



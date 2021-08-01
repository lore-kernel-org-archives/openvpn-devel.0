Date: Sun, 1 Aug 2021 18:52:59 +0200 (CEST)
Message-Id: <202108011652.171GqxL1045165@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210520151148.2565578-8-arne@...1227...>
References: <20210520151148.2565578-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --ncp-disable option
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

Stared at the code for a while... this all looks very reasonable,
except for removal of that warning

-        msg(M_WARN, "--cipher is not set. Previous OpenVPN version defaulted to
 "
-            "BF-CBC as fallback when cipher negotiation failed in this case. "
-            "If you need this fallback please add '--data-ciphers-fallback "
-            "BF-CBC' to your configuration and/or add BF-CBC to "
-            "--data-ciphers.");

.. which I find a bit surprising, since it was just recently added
to help users figure out why their existing configs "suddenly fail".

Discussed this on IRC, warning will come back with a cleanup patch
"soonish".


Threw this at the server side test rig, which has p2p instances, which
says: "Test sets failed: 4a 9 9a".

4a is spurious (FreeBSD, TAP, IPv6), but 9 / 9a are the p2p instances
that get broken by this patch, and partially (!) repaired by the next
one.

"9" is "--client" to "--tls-server".
"9a" is "--tls-client" (no -pull) to "--tls-server".

In both cases, the server does not set up data channel keys (as far
as I could determine) and then fails with something like this:

2021-07-28 19:45:16 us=967365 TLS Error: local/remote TLS keys are out of sync: [AF_INET6]2001:608:0:814::f000:21:29749 (received key id: 0, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_TRUE id=0 sid=6491e324 c7d580ce] [key#1 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000])
..
2021-07-28 19:45:18 us=260931 Bad LZO decompression header byte: 161
..
2021-07-28 19:40:31 us=196824 Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #2721835462 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
2021-07-28 19:40:31 us=196836 Fatal decryption error (process_incoming_link), restarting


Adding

  data-ciphers-fallback BF-CBC
  data-ciphers BF-CBC

to the server side config makes it work, though <<<--!!!  (basically,
disabling any server-side attempt at NCP, as "there is only one choice",
I think).

Since this is document to break p2p, and the next patch (in this series)
un-breaks this - well, breaks it in different ways - we move forward.

Your patch has been applied to the master branch.

commit caacd629f872c37c39453d3d0f2dfac229c921b1
Author: Arne Schwabe
Date:   Thu May 20 17:11:47 2021 +0200

     Remove --ncp-disable option

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210520151148.2565578-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22418.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering



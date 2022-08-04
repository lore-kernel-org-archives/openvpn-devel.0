Date: Thu, 4 Aug 2022 11:47:32 +0200 (CEST)
Message-Id: <202208040947.2749lWMl029416@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220804064016.20414-1-a@...2181...>
References: <20220804064016.20414-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: check that pulled options
 are compatible
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for shuffling this around a bit :-)

Tis is the same code change as v3, with a bit of reformatting in the
message and comment, and it's applied in "part1" now (do_deferred_options()).

Does nothing if DCO is not available (not compiled in / no kernel support),
does the right thing on DCO active with "--pull-filter ignore peer-id":

2022-08-04 10:30:38 Pushed option removed by filter: 'peer-id 0'
2022-08-04 10:30:38 OPTIONS IMPORT: timers and/or timeouts modified
2022-08-04 10:30:38 OPTIONS IMPORT: compression parms modified
2022-08-04 10:30:38 OPTIONS IMPORT: --ifconfig/up options modified
2022-08-04 10:30:38 OPTIONS IMPORT: route options modified
2022-08-04 10:30:38 OPTIONS IMPORT: data channel crypto options modified
2022-08-04 10:30:38 OPTIONS IMPORT: Server did not request DATA_V2 packet format required for data channel offload
2022-08-04 10:30:38 OPTIONS ERROR: pushed options are incompatible with data channel offload. Use --disable-dco to connect to this server
2022-08-04 10:30:38 ERROR: Failed to apply push options


As discused on IRC, I have changed D_TLS_ERRORS to D_PUSH_ERRORS - which
is also "level 1", but fits the intent better.

Your patch has been applied to the master branch.

commit 46f6a7e8b6daf02bebe4a46498665274f1673ac0
Author: Antonio Quartulli
Date:   Thu Aug 4 08:40:16 2022 +0200

     dco: check that pulled options are compatible

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220804064016.20414-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24797.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering



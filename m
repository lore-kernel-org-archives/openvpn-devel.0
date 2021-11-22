MIME-Version: 1.0
References: <20211117035321.249-1-lstipakov@...277...>
 <YZtTVZDWtTEecS/v@...1296...>
In-Reply-To: <YZtTVZDWtTEecS/v@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 22 Nov 2021 12:20:08 +0200
Message-ID: <CAGyAFMXM9aTQqbz6K-vu5gguARscTHEOb2++ZRgNh1uGX6+yXQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH master+release/2.5] Tune down verbosity
 for suspected retransmits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

I've discussed this with James, in his opinion it is not needed to be
fixed in openvpn3 server side, since those duplicated packets are
dropped anyway in openvpn2/3 clients. OpenVPN3 client doesn't display
those errors but increments error counter, which is then dumped to log
on disconnect. The problem is mostly with openvpn2 client, which
displays those replay errors with very high verbosity levels:

  #define D_REPLAY_ERRORS      LOGLEV(1, 6, M_NONFATAL)   /* show
packet replay errors */
  #define D_TLS_ERRORS         LOGLEV(1, 3, M_NONFATAL)   /* show TLS
control channel errors */

The first one can be muted with --mute-replay-warnings, but we still
have the second one.

--
-Lev


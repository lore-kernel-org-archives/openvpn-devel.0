MIME-Version: 1.0
References: <20210618171933.28985-1-gert@...1296...>
 <20210618181246.30769-1-gert@...1296...>
In-Reply-To: <20210618181246.30769-1-gert@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 21 Jun 2021 10:00:29 +0300
Message-ID: <CAGyAFMW9kAGAcXp1s7gWR6AU=N5uxJQVST1nrxW0pHrCHnhn7w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add error reporting to
 get_console_input_win32().
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Tested with MSVC. It is now easier to diagnose problems:

2021-06-20 23:57:28 us=812000 get_console_input_win32(): unexpected
error: No such device or address (errno=6)
2021-06-20 23:57:28 us=812000 ERROR: Failed retrieving username or password
2021-06-20 23:57:28 us=812000 Exiting due to fatal error

 which are to be fixed.

Acked-by: Lev Stipakov <lstipakov@...277...>


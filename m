Date: Mon, 14 Aug 2023 11:02:23 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZNntn0Hf0RjViWJJ@...2685...>
References: <20230814060409.50742-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20230814060409.50742-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Make received OCC exit messages more
 visible in log.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Aug 14, 2023 at 08:04:09AM +0200, Gert Doering wrote:
> Currently, OCC exit messages are only logged at some high debug level
> (and if OpenVPN compiled with DEBUG), while control-channel EEN messages
> are logged on verb 1.  Make this consistent, both in wording and in
> log level.
> 
> Both messages are prefixed with the "channel" where the exit message
> came in.

Makes sense to me.

Acked-by: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld


Date: Thu, 18 Feb 2010 20:25:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100218192530.GC9556@...1296...>
References: <1266515908-24807-1-git-send-email-kop@...1304...>
Mime-Version: 1.0
In-Reply-To: <1266515908-24807-1-git-send-email-kop@...1304...>
Subject: Re: [Openvpn-devel] Make sample-scripts/verify-cn dynamic
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Feb 18, 2010 at 11:58:27AM -0600, Karl O. Pinc wrote:
> Re: [PATCH] Change verify-cn so cn is no longer hardcoded in openvpn's config file

ACK from my end.  The code looks sane and I can see the usefulness.

(Backwards compatibility would be very easy to add - "if the argument does
not start with a "/", treat as CN - but as you said, this is just a 
sample script anyway).

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...


Date: Thu, 6 Feb 2020 11:52:17 +0100
From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20200206105217.GA7445@...2540...>
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-2-domagoj@...2540...>
 <99D61A626FDA8A4B90A270669121BE10D06B2CA0@...2294...>
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10D06B2CA0@...2294...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip DNS address validation
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Hi!

On Thu, Feb 06, 2020 at 09:58:37AM +0000, Simon Rozman wrote:
> Hi,
> 
> My thoughts exactly: as Lev pointed out:
> https://github.com/rozmansi/openvpn/commit/6b746cb0bf72a75e9963cc1a037c18cfb
> 856702a
> 
> Acked-by: Simon Rozman <simon@...2293...>
> 
> Domagoj, if it's not too much for you, maybe document the reason why DNS
> validation is so slow in the commit message. My wording went like this:
> 
> > DNS validation usually fails, as the pushed routes should be added first
> > to make DNS servers not part of the OpenVPN subnet reachable before
> > instructing Windows to use them.
> 
> Maybe Gert can update the commit message when applying?

Absolutely, Gert can add your additional description in the commit.

Regards,
Domagoj


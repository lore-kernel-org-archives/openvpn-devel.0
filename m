Date: Thu, 24 Dec 2020 13:03:37 +0100
From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20201224120337.GA9438@...2540...>
References: <20201215173950.26596-1-domagoj@...2540...>
 <20201220204812.GV976@...1296...>
 <CAGyAFMXCZEn3TA0gQi7_P9VTrRmGo2qCY8vyLZEM6dg3akvqDw@...278...>
MIME-Version: 1.0
In-Reply-To: <CAGyAFMXCZEn3TA0gQi7_P9VTrRmGo2qCY8vyLZEM6dg3akvqDw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Remove 1 second delay before running
 netsh
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
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi!

I've sent a new patch that uses management_sleep(0) instead.

I've also added your explanation why management_sleep(0) is used.

Regards,
Domagoj

On Mon, Dec 21, 2020 at 10:06:57AM +0200, Lev Stipakov wrote:
> Hi,
> 
> > Lev: do you have a particular opinion on this change?  You do more
> > testing with wintun...
> 
> Wintun uses iservice where we don't have those delays.
> 
> I tend to agree with Vladislav (themiron), let's use management_sleep(0) which
> processes any pending actions on the management interface without any wait.
> 
> -Lev


MIME-Version: 1.0
References: <20201215173950.26596-1-domagoj@...2540...>
 <20201220204812.GV976@...1296...>
In-Reply-To: <20201220204812.GV976@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 21 Dec 2020 10:06:57 +0200
Message-ID: <CAGyAFMXCZEn3TA0gQi7_P9VTrRmGo2qCY8vyLZEM6dg3akvqDw@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Domagoj Pensa <domagoj@...2540...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> Lev: do you have a particular opinion on this change?  You do more
> testing with wintun...

Wintun uses iservice where we don't have those delays.

I tend to agree with Vladislav (themiron), let's use management_sleep(0) which
processes any pending actions on the management interface without any wait.

-Lev


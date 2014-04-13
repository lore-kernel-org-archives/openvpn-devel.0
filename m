MIME-Version: 1.0
In-Reply-To: <20140413104705.GL16637@...1296...>
References: <1397366216-657-1-git-send-email-cernekee@...277...>
	<20140413104705.GL16637@...1296...>
From: Kevin Cernekee <cernekee@...277...>
Date: Sun, 13 Apr 2014 07:39:18 -0700
Message-ID: <CAJiQ=7DYg6PnTJ0piiUDKaT5wefVBxvPH3ZPHANQxOgWeDHjPg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Support non-root operation using
	ocproxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Apr 13, 2014 at 3:47 AM, Gert Doering <gert@...1296...> wrote:
> I think the goal can in most cases be achieved using SSH port forwarding -
> or OpenConnect, or a myriad of other "tunnel this file descriptor for me"
> tools.  OpenVPN will do tun/tap, and do that well.

The problem with all of these alternatives (at least in my case) is
that the other end is already running OpenVPN, not one of the other
tools.  Right now, there aren't a lot of good ways to connect to
somebody's OpenVPN service without running as root.  Prior to this
work I had been using separate VMs.

Are there any changes you could suggest that would make this feature
more palatable?


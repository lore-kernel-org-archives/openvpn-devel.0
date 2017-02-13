Date: Mon, 13 Feb 2017 20:50:41 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170213204947.10458306@...2245...>
In-Reply-To: <20170213193338.GV93896@...1296...>
References: <20170213201758.0a04ecfa@...1799...>
	<20170213193338.GV93896@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 13 Feb 2017 20:33:38 +0100
Gert Doering <gert@...1296...> wrote:
> On Mon, Feb 13, 2017 at 08:17:58PM +0100, Christian Hesse wrote:
> > Arch Linux is about to upgrade openssl to version 1.1.0. OpenVPN
> > does not compile against this version. Did anybody start the work
> > to support latest openssl versions?  
> 
> How does Arch deal with OpenSSH (which doesn't compile with 1.1.0
> either, at least "out of the repo")?

Good question... I am not responsible for the openssh package. Gaetan
has to deal with it.

And a lot more has to be done... There's a long list of packages to be
fixed. Sadly openssl developers do not care about ABI and API stability
or compatibility. :(
-- 
Best regards,
Chris


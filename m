Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
From: Wolfgang Ocker <weo@...66...>
In-Reply-To: <Pine.LNX.4.50.0302091959100.10985-100000@...48...>
References: <200302080347.h183lrf20924@...41...>
	 <Pine.LNX.4.50.0302091959100.10985-100000@...48...>
Message-Id: <1044873940.28711.12.camel@...67...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb 12 01:07:05 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Mon, 2003-02-10 at 02:01, Aaron Sethman wrote:
> Here is a simple little replacement for system() that does close file
> descriptors.  The main issue with it is though, it ends up picking an
> arbitrary number of fds to close.  I picked closing 0 to 99.

You can use getdtablesize() to determine the maximum number of open files
available to the process.

Wolfgang



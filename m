Message-ID: <9e0cf0bf0803182336t70bbbf1oabbfdd6b66e0ff4e@...278...>
Date: Wed, 19 Mar 2008 08:36:42 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <14528614@...83...>
MIME-Version: 1.0
References: <14528614@...83...>
Subject: Re: [Openvpn-devel] patch pkcs11 dynamic key id detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Peter Koch <pk@...1082...>
Cc: openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

Hi!

On 3/19/08, Peter Koch <pk@...1082...> wrote:
> We only use smartcard readers with secure pin entry.

Nice! You are the first one to confirm that protected authentication
actually works!
I never had the hardware to test it out.

>  Where can I find more information about the management interface?
>  I agree - it shoud be very easy to let OpenVPN automatically know
>  which certificate to use.

You can review the protocol at [1].
A simple sample I wrote in perl at [2].

I believe it should be very simple to convert [2] into none
interactive script for Windows.
This script can be installed as service using servany utility [3] from
the resource kit, or use [4].

You can also use Windows Task Scheduler to do the work.

Alon.

[1] http://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21/openvpn/management/management-notes.txt
[2] http://alon.barlev.googlepages.com/openvpn-kde-dialogs.pl.bz2
[3] http://www.perlguy.com/articles/nt_service.html
[4] http://search.cpan.org/~daveroth/Win32-Scheduler_v20000702/lib/Win32/Scheduler.PM


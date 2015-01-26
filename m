Message-ID: <54C6988E.6070901@...68...>
Date: Mon, 26 Jan 2015 20:42:06 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1422261503-1412-1-git-send-email-samuli@...515...>
	<1422277453.5382.25.camel@...1866...>
In-Reply-To: <1422277453.5382.25.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Add more dash escaping to the man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 26.01.2015 um 14:04 schrieb David Woodhouse:

> FWIW I *can* search for 'For --management-client' even before this
> patch, on Fedora 21. Changing to \- isn't required to fix the searching
> here. Is it still required on Debian?

I have a rather faint recollection because I tried fixing this in one of
my projects, possibly fetchmail, and figured that some distros, once
upon a time, had hacked some of their roff files in an effort to cater
for broken man pages and render things more beautifully... chances are
you get different results on older distros.



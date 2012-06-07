Message-ID: <4FD0935A.5050604@...515...>
Date: Thu, 07 Jun 2012 14:41:14 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4FD0735C.7090902@...515...> <CBF6422A.24DA%brabander@...1435...>
	<1CED409804E2164C8104F9E623B08B9012D498A813@...1436...>
	<4FD078F5.7060903@...1543...>
	<20120607102517.GR1059@...1296...>
In-Reply-To: <20120607102517.GR1059@...1296...>
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Thu, Jun 07, 2012 at 11:48:37AM +0200, Paul Bakker wrote:
>> Agreed as well..
> So what...?  1.1.4 or "1.1.0, and put the responsibility on the distro"?
>
I think this question is related to our project policies, not just to
PolarSSL support. Do we want to try to protect packagers and those
building from source from security issues by trying to force them to use
latest libraries? In practice, some OS/distro packagers (e.g. for Debian
stable) would have to circumvent our version checks due their own
project policies.

Anyways, whatever we decide, I think we should at least be consistent.

Samuli


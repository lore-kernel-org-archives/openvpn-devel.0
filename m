References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f73269d2-ba02-5360-9498-378f1e221a56@...277...>
	<CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
	<d9c2e940-e72b-cb12-193d-a164bc4ac270@...277...>
	<CAFHpkQF2fF_69jsquGJ=eamkSMVWPRbO7bFOLixP=27QgEEs5g@...278...>
	<CAKuzo_gL-D8mSbOvEzN6N1MZ816=f1xNP_ZUzyiucb4-K0t0hg@...278...>
	<CAFHpkQH3kE62G-EtavknAAZWOdS=0wkERy9FfYyDpbCKZuuHNw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <79b0624d-53fe-8e17-c58a-221434caad32@...1227...>
Date: Tue, 13 Jun 2017 21:54:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQH3kE62G-EtavknAAZWOdS=0wkERy9FfYyDpbCKZuuHNw@...278...>
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 
> 
> if user is administrator, interactive service is not used.
> well, I did miss that about interactive service.
>  

I wonder we should always use the interactive service if available and
add (dont-use-interactive) option, so behaviour is always the same.

Arne



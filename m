Message-ID: <9e0cf0bf0705202145r2ea770cbh99e656ce630de45f@...278...>
Date: Mon, 21 May 2007 07:45:53 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <20070520231131.GB19461@...172...>
MIME-Version: 1.0
References: <20070516135709.GE26428@...172...>
	<20070516145917.GC36293@...1026...>
	<20070520231131.GB19461@...172...>
Subject: Re: [Openvpn-devel] Smartcard Authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Jochen Kaiser <Jochen.Kaiser@...1025...>, openvpn devel <openvpn-devel@lists.sourceforge.net>, Michael Gernoth <simigern@...172...>

On 5/21/07, sithglan@...162... <sithglan@...162...> wrote:
> I got ssh-agent also working. At the moment I am only able to use 1024
> bit RSA keys under Linux. ssh-agent and openvpn doesn't work at the same
> time. :-( It seems that OpenVPN keeps the connection open and blocks
> ssh-agent from doing anything with the smart-card.

How do you use with OpenSSH?
I recommend of using PKCS#11 as well.
http://alon.barlev.googlepages.com/openssh-pkcs11

I don't use OpenSC, but I heard that there is some  kind of option
that causes PKCS#11 to release the session. Something related to PIN
caching?

Alon


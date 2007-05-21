Message-ID: <9e0cf0bf0705211145r79d4c226g3eb24db31a55f3de@...278...>
Date: Mon, 21 May 2007 21:45:46 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <20070521050705.GC19461@...172...>
MIME-Version: 1.0
References: <20070516135709.GE26428@...172...>
	<20070516145917.GC36293@...1026...>
	<20070520231131.GB19461@...172...>
	<9e0cf0bf0705202145r2ea770cbh99e656ce630de45f@...278...>
	<20070521050705.GC19461@...172...>
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
To: Alon Bar-Lev <alon.barlev@...277...>, Jochen Kaiser <Jochen.Kaiser@...1025...>, openvpn devel <openvpn-devel@lists.sourceforge.net>, Michael Gernoth <simigern@...172...>, Markus Friedl <Markus.Friedl@...1027...>

On 5/21/07, sithglan@...162... <sithglan@...162...> wrote:
> Note: It isn't enough to have a private/public key on the card. You also
> need a certificate. The certificate can be self signed. It doesn't
> matter. If there is _no_ certificate ssh-agent refuses to add it. Don't
> ask me why. Markus, can you answer that for me?

Because you need to have a public object.
The same is for PKCS#11 patch.

> Actually from my point of view opensc is cleaner because it doesn't
> include using binary modules from aladdin. Also for ssh for example I
> need to use a third party patch. opensc support is in openssh for ages
> (since 2001).

But what happens if you remove and insert your card? You should be
prompted to enter your PIN again, and you don't - security flaw.
What happen if you ssh and the card is missing? You should be prompted
to insert your card... and it just fails.
Why can't you load all your identities into the agent without having
your card in?
Why use none standard interface anyway?

But it is your choice... :)
I just make application standard. If they were you get a lot easier environment.

> Btw have to talked to Markus Friedel if your code does it make upstream?

I've talked with Damien Miller, but one day he just disappeared.

> > I don't use OpenSC, but I heard that there is some  kind of option
> > that causes PKCS#11 to release the session. Something related to PIN
> > caching?
>
> Might be possible. Do you have an specifics or patch that I could try?

This should be already built in... Just don't know where... I heard
people solved this issue. This is incompatibility of OpenSC PKCS#11
provider, the PKCS#11 states that multiple application should be able
to work at the same time.

> Btw. I had a quick glance at the OpenVPN pkcs#11 Code Base and it is
> quite impressive at least in the lines of code. How long did it take you
> to develop them?

Well... it is generic and used by different projects, so I moved this
to OpenSC project.
You can find some more utilities at:
http://alon.barlev.googlepages.com/open-source

Best Regards,
Alon Bar-Lev.

